Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34002 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbcJCTf4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 15:35:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id b201so11098468wmb.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Oct 2016 12:35:55 -0700 (PDT)
Date: Mon, 3 Oct 2016 21:35:51 +0200
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH] iio: common: st_sensors: fix channel data parsing
Message-ID: <20161003193550.GA31585@lorenzobianconi.net>
References: <1475093161-7239-1-git-send-email-lorenzo.bianconi@st.com>
 <45809aef-5396-90fa-1312-677eaeec36da@kernel.org>
 <CAA2SeNKCr3+rWJd2_Laa0UriPs0FUUWzy6c-s7-smFRSJEk0vQ@mail.gmail.com>
 <8b3ae000-43fc-9624-acc6-8416ef22fb5f@kernel.org>
 <57F22A77.6090706@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <57F22A77.6090706@parrot.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Sorry for the delay (vacations). Answers inline...

Hi Gregor,

> 
> 
> On 10/01/2016 04:58 PM, Jonathan Cameron wrote:
> >On 01/10/16 15:18, Lorenzo Bianconi wrote:
> >>>On 28/09/16 21:06, Lorenzo Bianconi wrote:
> >>>>Using realbits as i2c/spi read len, when that value is not byte aligned
> >>>>(e.g 12 bits), lead to skip msb part of out data registers.
> >>>>Fix this using storagebits as read length
> >>>>
> >>>>Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> >>>Hi Lorenzo,
> >>Hi Jonathan,
> >>
> >>>This would ideally have had a fixes tag.
> >>>
> >>>I think it was
> >>>Fixes: e7385de5 ("iio:st_sensors: align on storagebits boundaries")
> >>>Doing that would also have lead to you to the logic that lead to
> >>>this buggy change in the first place. Would also have shown
> >>>you that there is another place that probably suffers from the
> >>>same sort of issue.
> >>>
> >>Right. I missed the same issue in st_sensors_read_axis_data()
> >>
> >>>Gregor can you take a look at this please.
> >>>
> >>>If I recall the issue that lead to the original patch it was
> >>>that we were miss handling 24 bit values on pressure sensors and
> >>>this was intended to pad them?
> >>>
> >>>I think the 'right' fix will be something along the lines of:
> >>>unsigned int bytes_to_read = (channel->scan_type.realbits + 7) >> 3;
> >>>
> >>This should not be correct if you consider 8bit accel like LIS331DL.
> >8 + 7 = 15
> >15 >> 3 = 1 byte.
> >
> >Would get interest if the data was shifted to run across two bytes, but
> >it's not.  Could handle that case as well by doing
> >(channel->scan_type.realbits + channel->scan_type.shift + 7) >> 3
> Agreed.Maybe using DIV_ROUND_UP() would make ita bit clearer ? Something
> like :
> DIV_ROUND_UP(channel->scan_type.realbits + channel->scan_type.shift, 8)
> 
> Should alsobe applied to st_sensors_get_buffer_element() and
> st_sensors_read_axis_data() functions as told earlier.
> 
> 
> >>Taking a look to lps22hb code I think storagebits should be 24 and not
> >>32 for pressure channel. What do you think?
> >No. Storage bytes must always be a power of 2. It's assumed at various
> >points in the buffer handling code in the core and userspace code.
> >This is why Gregor's fix was needed.
> That was it.
> 
> I'll be happy to perform some testing with my setup (LPS22HB).

Today I tested the patch inline on 8,12,16 bit device and it worked properly.
I had no the chance to test it on 24 bit device (lps22hb). Can you give it a
whirl?

Thanks,
Lorenzo

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 4 +++-
 drivers/iio/common/st_sensors/st_sensors_core.c   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index fe7775b..df40452 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -30,7 +30,9 @@ static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 
 	for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {
 		const struct iio_chan_spec *channel = &indio_dev->channels[i];
-		unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
+		unsigned int bytes_to_read =
+			DIV_ROUND_UP(channel->scan_type.realbits +
+				     channel->scan_type.shift, 8);
 		unsigned int storage_bytes =
 			channel->scan_type.storagebits >> 3;
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 285a64a..afd60a6 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -483,8 +483,10 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	int err;
 	u8 *outdata;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
-	unsigned int byte_for_channel = ch->scan_type.realbits >> 3;
+	unsigned int byte_for_channel;
 
+	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
+					ch->scan_type.shift, 8);
 	outdata = kmalloc(byte_for_channel, GFP_KERNEL);
 	if (!outdata)
 		return -ENOMEM;
-- 
2.7.4

> 
> Regards,
> Grégor.
> 
> >
> >These 24 bit packed readings are a pain, but it was much worse to try
> >and remove the aligned data assumptions that need them to be powers
> >of 2.  Just think about 3 bytes floating in a little endian integer
> >field vs the big endian version. It's a real pain to unwind.
> >>>Should give 2 bytes for a 12 bit and still the 3 bytes needed for a
> >>>24 bit read.
> >>>
> >>>Thanks,
> >>>
> >>Thanks,
> >>Lorenzo
> >>
> >>>Jonathan
> >>>>---
> >>>>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 5 ++---
> >>>>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>>>
> >>>>diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> >>>>index fe7775b..d01aa34 100644
> >>>>--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> >>>>+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> >>>>@@ -30,16 +30,15 @@ static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> >>>>
> >>>>       for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {q
> >>>>               const struct iio_chan_spec *channel = &indio_dev->channels[i];
> >>>>-             unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
> >>>>               unsigned int storage_bytes =
> >>>>                       channel->scan_type.storagebits >> 3;
> >>>>
> >>>>               buf = PTR_ALIGN(buf, storage_bytes);
> >>>>               if (sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> >>>>                                                 channel->address,
> >>>>-                                               bytes_to_read, buf,
> >>>>+                                               storage_bytes, buf,
> >>>>                                                 sdata->multiread_bit) <
> >>>>-                 bytes_to_read)
> >>>>+                 storage_bytes)
> >>>>                       return -EIO;
> >>>>
> >>>>               /* Advance the buffer pointer */
> >>>>
> >>
> >>
> 

-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch; unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp; umount; make clean; sleep
