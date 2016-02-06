Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41100 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbcBFSW0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 13:22:26 -0500
Subject: Re: [PATCH v2] iio: Add helper function for calculating scan index
 storage size
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <1454426844-4276-1-git-send-email-lars@metafoo.de>
 <CAEnQRZAkwRJk1SNw5tGs6EdJ34ZVkmsyVEnmwv+mEQD16doA8w@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B639E0.1090702@kernel.org>
Date: Sat, 6 Feb 2016 18:22:24 +0000
MIME-Version: 1.0
In-Reply-To: <CAEnQRZAkwRJk1SNw5tGs6EdJ34ZVkmsyVEnmwv+mEQD16doA8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/02/16 14:35, Daniel Baluta wrote:
> On Tue, Feb 2, 2016 at 5:27 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> We have the same code for computing the scan index storage size in bytes
>> all over the place. Factor this out into helper functions.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Nice!
Indeed.
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
as per normal.

Jonathan
> 
>> ---
>> Changes since v1:
>>         * Workaround checkpatch.pl --strict warnings
>> ---
>>  drivers/iio/industrialio-buffer.c | 59 +++++++++++++++++----------------------
>>  1 file changed, 25 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index 139ae91..b976332 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -512,33 +512,41 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
>>         return sprintf(buf, "%d\n", iio_buffer_is_active(indio_dev->buffer));
>>  }
>>
>> +static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
>> +                                            unsigned int scan_index)
>> +{
>> +       const struct iio_chan_spec *ch;
>> +       unsigned int bytes;
>> +
>> +       ch = iio_find_channel_from_si(indio_dev, scan_index);
>> +       bytes = ch->scan_type.storagebits / 8;
>> +       if (ch->scan_type.repeat > 1)
>> +               bytes *= ch->scan_type.repeat;
>> +       return bytes;
>> +}
>> +
>> +static unsigned int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
>> +{
>> +       return iio_storage_bytes_for_si(indio_dev,
>> +                                       indio_dev->scan_index_timestamp);
>> +}
>> +
>>  static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>>                                 const unsigned long *mask, bool timestamp)
>>  {
>> -       const struct iio_chan_spec *ch;
>>         unsigned bytes = 0;
>>         int length, i;
>>
>>         /* How much space will the demuxed element take? */
>>         for_each_set_bit(i, mask,
>>                          indio_dev->masklength) {
>> -               ch = iio_find_channel_from_si(indio_dev, i);
>> -               if (ch->scan_type.repeat > 1)
>> -                       length = ch->scan_type.storagebits / 8 *
>> -                               ch->scan_type.repeat;
>> -               else
>> -                       length = ch->scan_type.storagebits / 8;
>> +               length = iio_storage_bytes_for_si(indio_dev, i);
>>                 bytes = ALIGN(bytes, length);
>>                 bytes += length;
>>         }
>> +
>>         if (timestamp) {
>> -               ch = iio_find_channel_from_si(indio_dev,
>> -                                             indio_dev->scan_index_timestamp);
>> -               if (ch->scan_type.repeat > 1)
>> -                       length = ch->scan_type.storagebits / 8 *
>> -                               ch->scan_type.repeat;
>> -               else
>> -                       length = ch->scan_type.storagebits / 8;
>> +               length = iio_storage_bytes_for_timestamp(indio_dev);
>>                 bytes = ALIGN(bytes, length);
>>                 bytes += length;
>>         }
>> @@ -1288,7 +1296,6 @@ static int iio_buffer_add_demux(struct iio_buffer *buffer,
>>  static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>>                                    struct iio_buffer *buffer)
>>  {
>> -       const struct iio_chan_spec *ch;
>>         int ret, in_ind = -1, out_ind, length;
>>         unsigned in_loc = 0, out_loc = 0;
>>         struct iio_demux_table *p = NULL;
>> @@ -1315,21 +1322,11 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>>                         in_ind = find_next_bit(indio_dev->active_scan_mask,
>>                                                indio_dev->masklength,
>>                                                in_ind + 1);
>> -                       ch = iio_find_channel_from_si(indio_dev, in_ind);
>> -                       if (ch->scan_type.repeat > 1)
>> -                               length = ch->scan_type.storagebits / 8 *
>> -                                       ch->scan_type.repeat;
>> -                       else
>> -                               length = ch->scan_type.storagebits / 8;
>> +                       length = iio_storage_bytes_for_si(indio_dev, in_ind);
>>                         /* Make sure we are aligned */
>>                         in_loc = roundup(in_loc, length) + length;
>>                 }
>> -               ch = iio_find_channel_from_si(indio_dev, in_ind);
>> -               if (ch->scan_type.repeat > 1)
>> -                       length = ch->scan_type.storagebits / 8 *
>> -                               ch->scan_type.repeat;
>> -               else
>> -                       length = ch->scan_type.storagebits / 8;
>> +               length = iio_storage_bytes_for_si(indio_dev, in_ind);
>>                 out_loc = roundup(out_loc, length);
>>                 in_loc = roundup(in_loc, length);
>>                 ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
>> @@ -1340,13 +1337,7 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>>         }
>>         /* Relies on scan_timestamp being last */
>>         if (buffer->scan_timestamp) {
>> -               ch = iio_find_channel_from_si(indio_dev,
>> -                       indio_dev->scan_index_timestamp);
>> -               if (ch->scan_type.repeat > 1)
>> -                       length = ch->scan_type.storagebits / 8 *
>> -                               ch->scan_type.repeat;
>> -               else
>> -                       length = ch->scan_type.storagebits / 8;
>> +               length = iio_storage_bytes_for_timestamp(indio_dev);
>>                 out_loc = roundup(out_loc, length);
>>                 in_loc = roundup(in_loc, length);
>>                 ret = iio_buffer_add_demux(buffer, &p, in_loc, out_loc, length);
>> --
>> 2.1.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

