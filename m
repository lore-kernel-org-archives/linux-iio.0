Return-Path: <lars@metafoo.de>
Message-ID: <5547CF8A.9060609@metafoo.de>
Date: Mon, 04 May 2015 21:59:06 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org
CC: jlbec@evilplan.org, knaack.h@gmx.de, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, octavian.purdila@intel.com,
 pebolle@tiscali.nl, patrick.porlan@intel.com, adriana.reus@intel.com,
 constantin.musca@intel.com, marten@intuitiveaerial.com
Subject: Re: [PATCH v5 2/4] iio: core: Introduce IIO configfs support
References: <1430736604-22119-1-git-send-email-daniel.baluta@intel.com> <1430736604-22119-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1430736604-22119-3-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 05/04/2015 12:50 PM, Daniel Baluta wrote:
> This creates an IIO configfs subystem named "iio", with a default "triggers"
> group.
>
> Triggers group is used for handling software triggers. To create a new software
> trigger one must create a directory inside the trigger directory.
>
> Software trigger name MUST follow the following convention:
> 	* <trigger-type>-<trigger-name>
> Where:
> 	* <trigger_type>, specifies the interrupt source (e.g: hrtimer)
> 	* <trigger-name>, specifies the IIO device trigger name
>
> Failing to follow this convention will result in an directory creation error.
>
> E.g, assuming that hrtimer trigger type is registered with IIO software
> trigger core:
>
> $ mkdir /config/iio/triggers/hrtimer-instance1
>

Nice, short and clean. Looks pretty good. It's a bit of a shame that we 
can't have a per type directory, but if that's how configfs works I guess 
there is not much choice.

[...]
> +static struct config_group *trigger_make_group(struct config_group *group,
> +					       const char *name)
> +{
> +	char *type_name;
> +	char *trigger_name;
> +	char buf[MAX_NAME_LEN];
> +	struct iio_sw_trigger *t;
> +
> +	snprintf(buf, MAX_NAME_LEN, "%s", name);
> +
> +	/* group name should have the form <trigger-type>-<trigger-name> */
> +	type_name = buf;
> +	trigger_name = strchr(buf, '-');
> +	if (!trigger_name) {
> +		pr_err("Unable to locate '-' in %s. Use <type>-<name>.\n", buf);

Do we want to print this side channel message? Makes it pretty easy to spam 
the kernel log with a rouge application.

> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/* replace - with \0, this nicely separates the two strings */
> +	*trigger_name = '\0';
> +	trigger_name++;
> +
> +	t = iio_sw_trigger_create(type_name, trigger_name);
> +	if (IS_ERR(t))
> +		return ERR_CAST(t);
> +
> +	config_item_set_name(&t->group.cg_item, name);
> +
> +	return &t->group;
> +}
> +
> +static void trigger_drop_group(struct config_group *group,
> +			       struct config_item *item)
> +{
> +	struct iio_sw_trigger *t = to_iio_sw_trigger(item);
> +
> +	if (t)

t will never be NULL.

> +		iio_sw_trigger_destroy(t);
> +	config_item_put(item);
> +}
