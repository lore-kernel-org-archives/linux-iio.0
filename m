Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36032 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753416AbcC1IQ4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 04:16:56 -0400
Date: Mon, 28 Mar 2016 16:16:44 +0800
From: Denis Ciocca <denis.ciocca@st.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe BARBA <giuseppe.barba@st.com>
Subject: Re: [PATCH 1/4] iio: st_sensors: simplify buffer address handling
Message-ID: <20160328081644.GB5682@beicxl1122>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
 <20160328034233.GA5682@beicxl1122>
 <56F8E2D6.2040908@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <56F8E2D6.2040908@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

I'm checking rest of series, I would like to check internally with our designers about what Linus has reported.
Since in Europe today is still holiday, I will be back to you in a couple of days.

Thanks,
Denis


On |28 Mar 16 @ 09:52|, Jonathan Cameron wrote:
> On 28/03/16 04:42, Denis Ciocca wrote:
> > Hi Linus,
> > 
> > it makes sense to me. Thanks
> > 
> > Acked-by: Denis Ciocca <denis.ciocca@st.com>
> Applied to the togreg branch of iio.git.
> 
> Denis, any comments on the rest of the series?
> > 
> > 
> > On |24 Mar 16 @ 14:18|, Linus Walleij wrote:
> >> The driver goes to some length to dynamically allocate an array
> >> to hold the channel addresses. However no ST sensor has more than
> >> three channels (x, y, z at most). Instead of kmalloc():ing and
> >> kfree():in the address array, just use a fixed array of three
> >> elements.
> >>
> >> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> >> Cc: Denis Ciocca <denis.ciocca@st.com>
> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >> ---
> >>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 28 ++++++-----------------
> >>  1 file changed, 7 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> >> index e18bc6782256..73764961feac 100644
> >> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> >> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> >> @@ -24,19 +24,13 @@
> >>  
> >>  int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> >>  {
> >> -	u8 *addr;
> >> +	u8 addr[3]; /* no ST sensor has more than 3 channels */
> >>  	int i, n = 0, len;
> >>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> >>  	unsigned int num_data_channels = sdata->num_data_channels;
> >>  	unsigned int byte_for_channel =
> >>  			indio_dev->channels[0].scan_type.storagebits >> 3;
> >>  
> >> -	addr = kmalloc(num_data_channels, GFP_KERNEL);
> >> -	if (!addr) {
> >> -		len = -ENOMEM;
> >> -		goto st_sensors_get_buffer_element_error;
> >> -	}
> >> -
> >>  	for (i = 0; i < num_data_channels; i++) {
> >>  		if (test_bit(i, indio_dev->active_scan_mask)) {
> >>  			addr[n] = indio_dev->channels[i].address;
> >> @@ -57,10 +51,8 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> >>  			u8 *rx_array;
> >>  			rx_array = kmalloc(byte_for_channel * num_data_channels,
> >>  					   GFP_KERNEL);
> >> -			if (!rx_array) {
> >> -				len = -ENOMEM;
> >> -				goto st_sensors_free_memory;
> >> -			}
> >> +			if (!rx_array)
> >> +				return -ENOMEM;
> >>  
> >>  			len = sdata->tf->read_multiple_byte(&sdata->tb,
> >>  				sdata->dev, addr[0],
> >> @@ -68,7 +60,7 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> >>  				rx_array, sdata->multiread_bit);
> >>  			if (len < 0) {
> >>  				kfree(rx_array);
> >> -				goto st_sensors_free_memory;
> >> +				return len;
> >>  			}
> >>  
> >>  			for (i = 0; i < n * byte_for_channel; i++) {
> >> @@ -87,17 +79,11 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
> >>  			buf, sdata->multiread_bit);
> >>  		break;
> >>  	default:
> >> -		len = -EINVAL;
> >> -		goto st_sensors_free_memory;
> >> -	}
> >> -	if (len != byte_for_channel * n) {
> >> -		len = -EIO;
> >> -		goto st_sensors_free_memory;
> >> +		return -EINVAL;
> >>  	}
> >> +	if (len != byte_for_channel * n)
> >> +		return -EIO;
> >>  
> >> -st_sensors_free_memory:
> >> -	kfree(addr);
> >> -st_sensors_get_buffer_element_error:
> >>  	return len;
> >>  }
> >>  EXPORT_SYMBOL(st_sensors_get_buffer_element);
> >> -- 
> >> 2.4.3
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
