Return-Path: <octavian.purdila@intel.com>
MIME-Version: 1.0
In-Reply-To: <54D73C66.40404@kernel.org>
References: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>
	<1422662408-8149-5-git-send-email-octavian.purdila@intel.com>
	<1423155753.2136.164.camel@spandruv-DESK3.jf.intel.com>
	<54D73C66.40404@kernel.org>
Date: Mon, 9 Feb 2015 11:54:55 +0200
Message-ID: <CAE1zotLPhHh9RYBJE4u+N13AAdPESyQ0OjrkMWrfoWpH=L3EAg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] iio: bmc150: refactor slope duration and threshold update
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Feb 8, 2015 at 12:37 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 05/02/15 17:02, Srinivas Pandruvada wrote:
>> On Sat, 2015-01-31 at 02:00 +0200, Octavian Purdila wrote:
>>> Move the slope duration and threshold update in a separate function to
>>> reduce code duplicate between chip init and motion interrupt setup.
>>>
>>> Also move the slope update code from the interrupt setup function to
>>> the trigger set state function so that we can later refactor the
>>> interrupt code.
>>>
>>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> My only comment here is that I'd have preferred this being in a separate precursor
> series as it's not really connected to the hardware buffer stuff!
> Keep your series focused and if there is refactoring to be done, please
> do it first.
>

I will keep that in mind for the future and sorry for the trouble.
