Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57477 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbbEEUkn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2015 16:40:43 -0400
In-Reply-To: <5547CE60.5000300@metafoo.de>
References: <1430736604-22119-1-git-send-email-daniel.baluta@intel.com> <1430736604-22119-4-git-send-email-daniel.baluta@intel.com> <5547CE60.5000300@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v5 3/4] iio: trigger: Introduce IIO hrtimer based trigger
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 05 May 2015 14:51:05 +0100
To: Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: jlbec@evilplan.org, knaack.h@gmx.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, octavian.purdila@intel.com,
	pebolle@tiscali.nl, patrick.porlan@intel.com,
	adriana.reus@intel.com, constantin.musca@intel.com,
	marten@intuitiveaerial.com
Message-ID: <0944C1CC-6F9C-49C5-8195-994413B68680@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 4 May 2015 20:54:08 GMT+01:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 05/04/2015 12:50 PM, Daniel Baluta wrote:
>[...]
>> +IIO_HRTIMER_INFO_ATTR(sampling_frequency, S_IRUGO | S_IWUSR,
>> +		      iio_hrtimer_info_show_sampling_frequency,
>> +		      iio_hrtimer_info_store_sampling_frequency);
>
>I wonder if the sampling frequency should be configurable the regular
>IIO 
>API, just like any other IIO device. But things like min/max sampling 
>frequency should be configured in configfs.
Would have to be in the trigger dir rather than device... Makes sense to put it there.
Limits on it here seem like a sensible idea.
>
>[...]
>> +#endif /* CONFIGFS_FS */
>> +
>[...]
>> +static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char
>*name)
>> +{
>[...]
>> +#ifdef CONFIG_CONFIGFS_FS
>> +	config_group_init_type_name(&trig_info->swt.group, name,
>> +				    &iio_hrtimer_type);
>> +#endif
>
>This should probably have a helper function in the sw trigger core,
>that 
>gets stubbed out when CONFIG_FS is disabled. Otherwise we'll see the
>same 
>#ifdef in every software trigger driver.
>[...]
>> +}
>> +
>> +static int iio_trig_hrtimer_remove(struct iio_sw_trigger *swt)
>> +{
>> +	struct iio_hrtimer_info *trig_info;
>> +
>> +	trig_info = iio_trigger_get_drvdata(swt->trigger);
>> +
>> +	hrtimer_cancel(&trig_info->timer);
>> +
>> +	iio_trigger_unregister(swt->trigger);
>> +	iio_trigger_free(swt->trigger);
>
>There is a bit of a race condition here. hrtimer_cancel() should be
>called 
>between unregister and free, otherwise it might be re-armed before it
>is 
>unregistered.
>
>> +	kfree(trig_info);
>> +
>> +	return 0;
>> +}
>> +
>> +struct iio_sw_trigger_ops iio_trig_hrtimer_ops = {
>
>const
>
>> +	.probe		= iio_trig_hrtimer_probe,
>> +	.remove		= iio_trig_hrtimer_remove,
>> +};
>[...]
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
