Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:59330 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab2DMNzy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 09:55:54 -0400
Message-ID: <4F883063.1010707@cam.ac.uk>
Date: Fri, 13 Apr 2012 14:55:47 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH] staging: iio: add lsm303dlh magnetometer driver
References: <1333971244-10684-1-git-send-email-srinidhi.kasagar@stericsson.com> <4F834BE1.2010107@kernel.org> <20120413110930.GA28018@bnru02>
In-Reply-To: <20120413110930.GA28018@bnru02>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/13/2012 12:09 PM, Srinidhi Kasagar wrote:
> On Mon, Apr 09, 2012 at 22:51:45 +0200, Jonathan Cameron wrote:
>> On 04/09/2012 12:34 PM, Srinidhi KASAGAR wrote:
>>> Add support for lsm303dlh magnetometer device.
>>>
>>> Signed-off-by: srinidhi kasagar<srinidhi.kasagar@stericsson.com>
>>> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>> Hi Srinidhi,
>>
>> Basically a sound driver with a few easy bits to fix.
>>
>> Few nitpicks and the error paths in probe need another look.
> Hi Jonathan,
>
> Thanks a lot for the review.
>
>> The config attribute needs to go. If there is stuff in there you
>> need access to then it needs an abi that doesn't involve magic
>> numbers. (I'm hoping this is just a left over from debugging!)
> I agree, its a useless attribute, removed.
>
> [...]
>
>> We have the old question of _range attributes as well and their
>> interaction with scale.  I've always been dubious about these,
>> mainly because it's not entirely obvious how to format the
>> weirder general cases.  Do you have a pressing need for range
>> or could it just be dropped in favour of allowing write for the
>> scale parameter? If nothing else, scale is available for inkernel
>> users and range isn't.
> This one too, will drop range attribute, while keeping scale for the
> in kernel usage only.
>
> [...]
>
>>> +}
>>> +
>>> +static inline int is_device_on(struct lsm303dlh_m_data *data)
>>> +{
>> Just roll this next line into the place it is used.
> Not sure if I understood this properly.
>
> [...]
I've no idea what I was on about so ignore that!
>
>>> +static ssize_t set_operating_mode(struct device *dev,
>>> +                             struct device_attribute *attr,
>>> +                             const char *buf, size_t count)
>>> +{
>>> +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>> +     struct lsm303dlh_m_data *data = iio_priv(indio_dev);
>>> +     struct i2c_client *client = data->client;
>>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>>> +     int error;
>>> +     unsigned long mode = 0;
>>> +
>>> +     mutex_lock(&data->lock);
>>> +
>>> +     error = kstrtoul(buf, 10,&mode);
>>> +     if (error) {
>>> +             count = error;
>>> +             goto exit;
>>> +     }
>>> +
>> Hmm.. This is magic number teritory so needs a rething in the long run.
> Would like to keep this for the moment.
This is a big no no. If you have modes and really really want this level 
of control, then strings
please rather than magic numbers.  Leave for now if you like, but it'll 
need fixing before this
driver leaves staging.
>>> +     if (mode>  SLEEP_MODE) {
>>> +             dev_err(&client->dev, "trying to set invalid mode\n");
>>> +             count = -EINVAL;
>>> +             goto exit;
>>> +     }
> [...]
>
>>> +static int set_configuration(struct device *dev,
>>> +                             struct device_attribute *attr,
>>> +                             const char *buf, size_t count)
>> This looks like direct register access to me.  Magic numbers
>> are pretty much a no no so please get rid of this and associated
>> attribute
> OK, will remove.
>
> [...]
>
>>> +static struct attribute *lsm303dlh_m_attributes[] = {
>>> +&iio_dev_attr_config.dev_attr.attr,
>>> +&iio_dev_attr_mode.dev_attr.attr,
>> gah. Not your fault at all but we really need to standardise
>> this 'mode' type attributes (far from just an iio thing!)
>>
>>> +&iio_dev_attr_in_magn_range.dev_attr.attr,
>> hmm.. range isn't techincally in the abi (though I know there are
>> a few drivers using it). The issue is the interaction with scale
>> and scale is a lot easier to define a format for.
>> Could let it go here. It's not a parameter I'm particularly worried
>> about going through a slow deprecation for and there are a couple
>> of other users in tree. (particularly as you support scale here
>> as well!)  Actually, do you have a strong reason for supplying range
>> at all?
> Not really, I will keep the scale factors, and remove the range.
>
> Will fix the rest of the comments and send out the v2 version
> of the patch.
>
> Thanks,
> srinidhi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

