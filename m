Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:49391 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab1GRM4l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2011 08:56:41 -0400
Message-ID: <4E242D8C.8080300@cam.ac.uk>
Date: Mon, 18 Jul 2011 13:56:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH 2/2] iio: adc: New driver for AD7280A Lithium Ion Battery
 Monitoring System
References: <1310734743-2623-1-git-send-email-michael.hennerich@analog.com> <1310734743-2623-2-git-send-email-michael.hennerich@analog.com> <4E241C45.5090902@cam.ac.uk> <4E242BA8.8020006@analog.com>
In-Reply-To: <4E242BA8.8020006@analog.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/18/11 13:48, Michael Hennerich wrote:
> On 07/18/2011 01:43 PM, Jonathan Cameron wrote:
>> On 07/15/11 13:59, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich<michael.hennerich@analog.com>
>> Hi Michael, although anyone reading the datasheets will quickly
>> discover that this isn't a simple laptop style battery monitor,
>> it's probably worth making that clear in the patch title or
>> at very least here.
>>
>> Driver is pretty clear. Couple of nitpicks / queries inline.
>>
>> Thanks
>>
>> Jonathan
>>>
>>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>>> ---
...
>>> +static irqreturn_t ad7280_event_handler(int irq, void *private)
>>> +{
>>> +     struct iio_dev *dev_info = private;
>>> +
>>> +     iio_push_event(dev_info, 0,
>>> +                    IIO_UNMOD_EVENT_CODE(IIO_IN,
>>> +                                         0,
>>> +                                         IIO_EV_TYPE_THRESH,
>>> +                                         IIO_EV_DIR_EITHER),
>>> +                    iio_get_time_ns());
>> You have thresholds for temp and voltage below, but only voltage
>> event. I wonder if the right thing here is to issue two events
>> (subject to what is enabled).  If everything is turned on, there
>> doesn't seem to be anyway to tell what happened.  If the event
>> is consistent, I guess you could write a strobe function that would
>> enable events up the chain and see when it kicked in. That would
>> tell you where it came from.  No idea if one ever wants to know though.
> Alternatively I could read all channels in the stack and compare
> against the set thresholds. I think that would make the most sense here.
Good point. That's much simpler.
> 
>>
>>> +
>>> +     return IRQ_HANDLED;
>>> +}
>>> +
>>> +static IIO_DEVICE_ATTR(in_thresh_low_value,
>>> +                    S_IRUGO | S_IWUSR,
>>> +                    ad7280_read_channel_config,
>>> +                    ad7280_write_channel_config,
>>> +                    AD7280A_CELL_UNDERVOLTAGE);
>>> +
>>> +static IIO_DEVICE_ATTR(in_thresh_high_value,
>>> +                    S_IRUGO | S_IWUSR,
>>> +                    ad7280_read_channel_config,
>>> +                    ad7280_write_channel_config,
>>> +                    AD7280A_CELL_OVERVOLTAGE);
>>> +
>>> +static IIO_DEVICE_ATTR(temp_thresh_low_value,
>>> +                    S_IRUGO | S_IWUSR,
>>> +                    ad7280_read_channel_config,
>>> +                    ad7280_write_channel_config,
>>> +                    AD7280A_AUX_ADC_UNDERVOLTAGE);
>>> +
>>> +static IIO_DEVICE_ATTR(temp_thresh_high_value,
>>> +                    S_IRUGO | S_IWUSR,
>>> +                    ad7280_read_channel_config,
>>> +                    ad7280_write_channel_config,
>>> +                    AD7280A_AUX_ADC_OVERVOLTAGE);
>> These are shared over all channels?  Hmm. That's not a case
>> I'd considered when writing the chan spec stuff for events,
>> perhaps we need to allow for 'shared' events.  Technically
>> the only abi meeting approach right now is to have these
>> for every channel.  So write one channels threshold value
>> then a read would tell you they have all changed.
> Technically I could have different thresholds for any single
> device in the chain, each featuring 6 cell and 6 temp/aux channels.
> 
> But in practice, you would set them to all being the same.
> What prevents us from having the shared event thresholds?
The difficulty in concisely specifying them in the chan spec
structures.  Good point though, it's fine abi wise.  Maybe
just leave these as you have them here for now and we can
think about how to concisely map them into the chan_spec
stuff at a later date..
> 
>>> +
>>> +
>>> +static struct attribute *ad7280_event_attributes[] = {
>>> +&iio_dev_attr_in_thresh_low_value.dev_attr.attr,
>>> +&iio_dev_attr_in_thresh_high_value.dev_attr.attr,
>>> +&iio_dev_attr_temp_thresh_low_value.dev_attr.attr,
>>> +&iio_dev_attr_temp_thresh_high_value.dev_attr.attr,
>>> +     NULL,
>>> +};
>>> +
>>> +static struct attribute_group ad7280_event_attrs_group = {
>>> +     .attrs = ad7280_event_attributes,
>>> +};
>>> +
>>> +static int ad7280_read_raw(struct iio_dev *dev_info,
>>> +                        struct iio_chan_spec const *chan,
>>> +                        int *val,
>>> +                        int *val2,
>>> +                        long m)
>>> +{
>>> +     struct ad7280_state *st = iio_priv(dev_info);
>>> +     unsigned int scale_uv;
>>> +     int ret;
>>> +
>>> +     switch (m) {
>>> +     case 0:
>>> +             mutex_lock(&dev_info->mlock);
>>> +             switch (chan->type) {
>>> +             case IIO_IN:
>>> +                     ret = ad7280_read_channel(st, chan->address>>  8,
>>> +                                               chan->address&  0xFF);
>>> +                     break;
>>> +             case IIO_IN_DIFF:
>>> +                     ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
>> Err... Really need some explanation for what this channel is!
> Voltage across all cells.
Fair enough. So are the other voltages not differential as well? (across a given
cell rather than referred to a base voltage)
...

>>> +
>>> +#endif /* IIO_ADC_AD7280_H_ */
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> Thanks for the review.
> 
You are welcome.


