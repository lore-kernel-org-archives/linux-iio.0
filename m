Return-Path: <hadess@hadess.net>
Message-ID: <1474066311.6389.41.camel@hadess.net>
Subject: Re: possible odd acceleration scaling
From: Bastien Nocera <hadess@hadess.net>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
 "rrs@researchut.com" <rrs@researchut.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>,  "jic23@kernel.org" <jic23@kernel.org>
Date: Sat, 17 Sep 2016 00:51:51 +0200
In-Reply-To: <1474064901.26681.5.camel@intel.com>
References: <1473787814.8047.8.camel@researchut.com>
	 <a9078c9f-0d07-35bc-e449-2cfeee7b7987@kernel.org>
	 <d275ff67-4335-a6f4-b60b-c4227a59b34c@kernel.org>
	 <1473793566.6874.10.camel@linux.intel.com>
	 <1473843953.23872.3.camel@researchut.com>
	 <1473845312.23872.5.camel@researchut.com>
	 <1473861009.9913.7.camel@researchut.com>
	 <1473866880.35049.5.camel@linux.intel.com>
	 <1473867872.6389.16.camel@hadess.net>
	 <1473868832.9913.14.camel@researchut.com>
	 <1474047781.32019.1.camel@linux.intel.com>
	 <1474050391.18741.3.camel@researchut.com>
	 <1474050918.3066.0.camel@researchut.com>
	 <1474054303.20470.2.camel@linux.intel.com>
	 <1474054833.20470.4.camel@intel.com> <1474060746.6389.38.camel@hadess.net>
	 <1474064901.26681.5.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Fri, 2016-09-16 at 22:30 +0000, Pandruvada, Srinivas wrote:
> On Fri, 2016-09-16 at 23:19 +0200, Bastien Nocera wrote:
> On Fri, 2016-09-16 at 19:40 +0000, Pandruvada, Srinivas wrote:
> > 
> > On Fri, 2016-09-16 at 12:31 -0700, Srinivas Pandruvada wrote:
> > On Sat, 2016-09-17 at 00:05 +0530, Ritesh Raj Sarraf wrote:
> > > 
> > > 
> > > On Fri, 2016-09-16 at 23:56 +0530, Ritesh Raj Sarraf wrote:
> > > > 
> > > > 
> > > > 
> > > > I'll also confirm for 4.7 soon.
> > > 
> > > 
> > > Verified on 4.7 too and it is all good.
> > 
> > Thanks.
> > I will send a pull request with this patch.
> > 
> > Hi Bastien,
> > 
> > My original pull request for issue #99 already had this change.
> > Somehow
> > when merged to main, this change was removed.
> > May be just revert and pull again.
> 
> If you can explain the change, I'd be all for it, because I don't
> understand it.
> 
> Please check the attached patch with comments.

Duh! My mistake. Pushed with some small changes to the commit message,
thanks!
