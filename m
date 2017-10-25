Return-Path: <SRS0=aVu3=BY=users.sourceforge.net=elfring@kernel.org>
Subject: Re: [PATCH] iio/accel/bmc150: Improve unlocking of a mutex in two
 functions
To: Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <66d582a4-a77e-cd78-4215-49587ec2259e@users.sourceforge.net>
 <fb223eb2-ddab-396e-372e-e9496be8bf0f@redhat.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <c32ea2ea-5961-6589-6b51-1184d9565a38@users.sourceforge.net>
Date: Wed, 25 Oct 2017 18:15:32 +0200
MIME-Version: 1.0
In-Reply-To: <fb223eb2-ddab-396e-372e-e9496be8bf0f@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

> IMHO, if you do this, you should rework the function so that there is a single unlock call
> at the end, not a separate one in in error label.

Thanks for your update suggestion.

Does it indicate that I may propose similar source code adjustments
in this software area?


> Could e.g. change this:
> 
>         ret = bmc150_accel_set_power_state(data, false);
>         mutex_unlock(&data->mutex);
>         if (ret < 0)
>                 return ret;
> 
>         return IIO_VAL_INT;
> }
> 
> To:
> 
>         ret = bmc150_accel_set_power_state(data, false);
>         if (ret < 0)
>                 goto unlock;
> 
>     ret = IIO_VAL_INT;

How do you think about to use the following code variant then?

	if (!ret)
		ret = IIO_VAL_INT;


> unlock:
>         mutex_unlock(&data->mutex);
> 
>         return ret;
> }
> 
> And also use the unlock label in the other cases, this is actually
> quite a normal pattern. I see little use in a patch like this if there
> are still 2 unlock paths after the patch.

How long should I wait for corresponding feedback before another small
source code adjustment will be appropriate?

Regards,
Markus
