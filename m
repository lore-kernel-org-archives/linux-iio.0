Return-Path: <jkosina@suse.cz>
Date: Wed, 27 Nov 2013 15:59:09 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensors: Fix power and report state
In-Reply-To: <528EB575.7070700@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1311271558410.14638@pobox.suse.cz>
References: <1381267963-14669-1-git-send-email-srinivas.pandruvada@linux.intel.com> <525C6ECA.4020404@kernel.org> <525C6FCE.9060909@linux.intel.com> <525D9047.6060902@kernel.org> <525D8ABF.6000504@linux.intel.com> <525D9AB1.6070709@kernel.org>
 <alpine.LNX.2.00.1311211023190.22082@pobox.suse.cz> <0c3f994c-174c-41c9-8cb7-c6dd26ec125e@email.android.com> <528EB575.7070700@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 21 Nov 2013, Srinivas Pandruvada wrote:

> One way to do this is by adding a quirk field in hid_field structure also.
> This way, quirk can be
> enabled on a per field basis. Then we can have a common hid quirk at a device
> level and also individual field level.
> 
> Jiri, Do you have some suggestion?

I don't really see any better option. Could you please prepare a patch? It 
should be doable in a relatively clean way.

Thanks,

-- 
Jiri Kosina
SUSE Labs
