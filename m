Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57486 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757602AbbEEUko (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 May 2015 16:40:44 -0400
In-Reply-To: <5547CF8A.9060609@metafoo.de>
References: <1430736604-22119-1-git-send-email-daniel.baluta@intel.com> <1430736604-22119-3-git-send-email-daniel.baluta@intel.com> <5547CF8A.9060609@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v5 2/4] iio: core: Introduce IIO configfs support
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 05 May 2015 14:48:35 +0100
To: Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: jlbec@evilplan.org, knaack.h@gmx.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, octavian.purdila@intel.com,
	pebolle@tiscali.nl, patrick.porlan@intel.com,
	adriana.reus@intel.com, constantin.musca@intel.com,
	marten@intuitiveaerial.com
Message-ID: <0A2E66FA-1214-4494-9C4F-CA81B6862DF4@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 4 May 2015 20:59:06 GMT+01:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 05/04/2015 12:50 PM, Daniel Baluta wrote:
>> This creates an IIO configfs subystem named "iio", with a default
>"triggers"
>> group.
>>
>> Triggers group is used for handling software triggers. To create a
>new software
>> trigger one must create a directory inside the trigger directory.
>>
>> Software trigger name MUST follow the following convention:
>> 	* <trigger-type>-<trigger-name>
>> Where:
>> 	* <trigger_type>, specifies the interrupt source (e.g: hrtimer)
>> 	* <trigger-name>, specifies the IIO device trigger name
>>
>> Failing to follow this convention will result in an directory
>creation error.
>>
>> E.g, assuming that hrtimer trigger type is registered with IIO
>software
>> trigger core:
>>
>> $ mkdir /config/iio/triggers/hrtimer-instance1
>>
>
>Nice, short and clean. Looks pretty good. It's a bit of a shame that we
>
>can't have a per type directory, but if that's how configfs works I
>guess 
>there is not much choice.
>
We could but an intermediate mkdir would be needed from user space which
would have odd semantics!
>[...]
>> +static struct config_group *trigger_make_group(struct config_group
>*group,
>> +					       const char *name)
>> +{
>> +	char *type_name;
>> +	char *trigger_name;
>> +	char buf[MAX_NAME_LEN];
>> +	struct iio_sw_trigger *t;
>> +
>> +	snprintf(buf, MAX_NAME_LEN, "%s", name);
>> +
>> +	/* group name should have the form <trigger-type>-<trigger-name> */
>> +	type_name = buf;
>> +	trigger_name = strchr(buf, '-');
>> +	if (!trigger_name) {
>> +		pr_err("Unable to locate '-' in %s. Use <type>-<name>.\n", buf);
>
>Do we want to print this side channel message? Makes it pretty easy to
>spam 
>the kernel log with a rouge application.
>
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	/* replace - with \0, this nicely separates the two strings */
>> +	*trigger_name = '\0';
>> +	trigger_name++;
>> +
>> +	t = iio_sw_trigger_create(type_name, trigger_name);
>> +	if (IS_ERR(t))
>> +		return ERR_CAST(t);
>> +
>> +	config_item_set_name(&t->group.cg_item, name);
>> +
>> +	return &t->group;
>> +}
>> +
>> +static void trigger_drop_group(struct config_group *group,
>> +			       struct config_item *item)
>> +{
>> +	struct iio_sw_trigger *t = to_iio_sw_trigger(item);
>> +
>> +	if (t)
>
>t will never be NULL.
>
>> +		iio_sw_trigger_destroy(t);
>> +	config_item_put(item);
>> +}

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
