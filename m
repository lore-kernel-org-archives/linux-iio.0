Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <alpine.DEB.2.02.1503251817280.30570@pmeerw.net>
References: <1427302832-9336-1-git-send-email-daniel.baluta@intel.com>
	<1427302832-9336-4-git-send-email-daniel.baluta@intel.com>
	<alpine.DEB.2.02.1503251817280.30570@pmeerw.net>
Date: Wed, 25 Mar 2015 21:28:56 +0200
Message-ID: <CAEnQRZA6Y2GcNqi7UT5ipcHRPvA_tOh+Eqd4-v8tdQ0BaaPiRQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: Documentation: Add initial documentaton for IIO
From: Daniel Baluta <daniel.baluta@intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Joel Becker <jlbec@evilplan.org>, Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 25, 2015 at 7:22 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> On Wed, 25 Mar 2015, Daniel Baluta wrote:
>
>> This file wants to be a starting point document for anyone wanting
>> to use IIO configfs support or adding new IIO configfs functionality.
>
> typos below; I'm just trying to understand what's going on...

Hi Peter,

Thanks a lot for your time. I agree with all your comments for this patch
and will fix in v2.
<snip>

>> +* IIO on IIO drivers
>
> ??

I will add more details about this. I was trying to describe the IIO
elements that
would make sense to be configured via configfs.

Have a look at Jonathan's email:

http://marc.info/?l=linux-iio&m=142693832028677&w=2

thanks,
Daniel.
