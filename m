Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58468 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbcGPCyo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2016 22:54:44 -0400
Subject: Re: [PATCH v2 4/4] hwmon: iio: add label for channels read by
 iio_hwmon
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-5-git-send-email-quentin.schulz@free-electrons.com>
 <5788ED2D.9050405@roeck-us.net> <5788F506.3040809@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5789A1AC.1020706@roeck-us.net>
Date: Fri, 15 Jul 2016 19:53:32 -0700
MIME-Version: 1.0
In-Reply-To: <5788F506.3040809@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/15/2016 07:36 AM, Quentin Schulz wrote:
> On 15/07/2016 16:03, Guenter Roeck wrote:
>> On 07/15/2016 02:59 AM, Quentin Schulz wrote:
> [...]
>>> +static ssize_t iio_hwmon_read_label(struct device *dev,
>>> +                    struct device_attribute *attr,
>>> +                    char *buf)
>>> +{
>>> +    struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
>>> +    struct iio_hwmon_state *state = dev_get_drvdata(dev);
>>> +    const char *label =
>>> state->channels[sattr->index].channel->extend_name;
>>> +
>>> +    if (label)
>>> +        return sprintf(buf, "%s\n", label);
>>> +
>> Can the name disappear on the fly, or be changed on the fly ?
>> Then this is unusable. We should and can only provide labels
>> if a name exists and is permanent. Otherwise all we do is
>> to confuse user space.
>
> It cannot, the extend_name field is const char* in the struct:
> http://lxr.free-electrons.com/source/include/linux/iio/iio.h#L247
>

Then why "if(label)" ?

> [...]
>>> @@ -107,6 +123,18 @@ static int iio_hwmon_probe(struct platform_device
>>> *pdev)
>>>            }
>>>
>>>            sysfs_attr_init(&a->dev_attr.attr);
>>> +
>>> +        b = NULL;
>>> +        if (st->channels[i].channel->extend_name) {
>>> +            b = devm_kzalloc(dev, sizeof(*b), GFP_KERNEL);
>>> +            if (b == NULL) {
>>> +                ret = -ENOMEM;
>>> +                goto error_release_channels;
>>> +            }
>>> +
>>> +            sysfs_attr_init(&b->dev_attr.attr);
>>
>> Why is this initialization here and not with the rest of the initialization
>> of this attribute ?
>
> I don't get your question. I've followed the exact same pattern as for
> "a" variable's initialization.
> The initialization is before the switch case because the name of the
> exposed sysfs file depends on the type of the IIO channel. If I move the
> initialization in the switch case, I'll have duplicated code.
>

Yes, but that didn't require all those if statements.

>>> +        }
>>> +
>>>            ret = iio_get_channel_type(&st->channels[i], &type);
>>>            if (ret < 0)
>>>                goto error_release_channels;
>>> @@ -115,35 +143,66 @@ static int iio_hwmon_probe(struct
>>> platform_device *pdev)
>>>            case IIO_VOLTAGE:
>>>                a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>>>                                  "in%d_input",
>>> -                              in_i++);
>>> +                              in_i);
>>> +            if (b)
>>> +                b->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>>> +                                  "in%d_label",
>>> +                                  in_i);
>>> +            in_i++;
>>>                break;
>>>            case IIO_TEMP:
>>>                a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>>>                                  "temp%d_input",
>>> -                              temp_i++);
>>> +                              temp_i);
>>> +
>>> +            if (b)
>>> +                b->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>>> +                                  "temp%d_label",
>>> +                                  temp_i);
>>> +            temp_i++;
>>>                break;
>>>            case IIO_CURRENT:
>>>                a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>>>                                  "curr%d_input",
>>> -                              curr_i++);
>>> +                              curr_i);
>>> +
>>> +            if (b)
>>> +                b->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>>> +                                  "curr%d_label",
>>> +                                  curr_i);
>>> +            curr_i++;
>>>                break;
>>>            case IIO_HUMIDITYRELATIVE:
>>>                a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>>>                                  "humidity%d_input",
>>> -                              humidity_i++);
>>> +                              humidity_i);
>>> +
>>> +            if (b)
>>> +                b->dev_attr.attr.name = kasprintf(GFP_KERNEL,
>>> +                                  "humidity%d_label",
>>> +                                  humidity_i);
>>> +            humidity_i++;
>>>                break;
>>>            default:
>>>                ret = -EINVAL;
>>>                goto error_release_channels;
>>>            }
>>> -        if (a->dev_attr.attr.name == NULL) {
>>> +        if (a->dev_attr.attr.name == NULL ||
>>> +            (b && b->dev_attr.attr.name == NULL)) {
>>>                ret = -ENOMEM;
>>>                goto error_release_channels;
>>>            }
>>
>> Just realized that we have a memory leak here. The 'name' memory is
>> never released.
>>
>
> I don't know if we have to do something to revert the effects of
> sysfs_attr_init but you sure are right that the a and b's attribute's
> name is never freed. This case would be handled with devm_kasprintf, I
> guess? Thanks.
>
>>>            a->dev_attr.show = iio_hwmon_read_val;
>>>            a->dev_attr.attr.mode = S_IRUGO;
>>>            a->index = i;
>>> -        st->attrs[i] = &a->dev_attr.attr;
>>> +        st->attrs[j++] = &a->dev_attr.attr;
>>> +
>>> +        if (b) {

sysfs_attr_init() might be better here to keep the initialization of '*b'
as close together as possible.

Guenetr

>>> +            b->dev_attr.show = iio_hwmon_read_label;
>>> +            b->dev_attr.attr.mode = S_IRUGO;
>>> +            b->index = i;
>>> +            st->attrs[j++] = &b->dev_attr.attr;
>>> +        }
>>>        }
>>>
>>>        st->attr_group.attrs = st->attrs;
>>>
>>
>
> Quentin
>

