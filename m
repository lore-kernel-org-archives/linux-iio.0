Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:6897 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbdDFFSi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Apr 2017 01:18:38 -0400
Message-ID: <1491455916.6135.1.camel@linux.intel.com>
Subject: Re: [STABLE REGRESSION] iio: hid-sensor-trigger: Change get poll
 value function order to avoid sensor properties losing after resume from S3
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Song, Hongyan" <hongyan.song@intel.com>,
        "rrs@researchut.com" <rrs@researchut.com>,
        linux-iio <linux-iio@vger.kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 05 Apr 2017 22:18:36 -0700
In-Reply-To: <AE3E3DFA698D6144A7445C92D1D41E2F10BF7BCE@SHSMSX103.ccr.corp.intel.com>
References: <1491035833.10386.1.camel@researchut.com>
         <1491059661.30396.37.camel@linux.intel.com>
         <1491246858.17255.10.camel@researchut.com>
         <1491353080.3695.4.camel@linux.intel.com>
         <1491389519.7588.1.camel@researchut.com>
         <1491406549.9822.107.camel@linux.intel.com>
         <AE3E3DFA698D6144A7445C92D1D41E2F10BF7BCE@SHSMSX103.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Thu, 2017-04-06 at 04:58 +0000, Song, Hongyan wrote:
> Hi Srinivas,
> 	I have checked the patch dose not meets my requirement for ISH.
> With this patch sensor properties still losing after resume from S3.
What is your test case? I want to try.

Thanks,
Srinivas

> 
> BR
> Song Hongyan
> 
> -----Original Message-----
> From: Srinivas Pandruvada [mailto:srinivas.pandruvada@linux.intel.com
> ] 
> Sent: Wednesday, April 5, 2017 11:36 PM
> To: rrs@researchut.com; Song, Hongyan <hongyan.song@intel.com>;
> linux-iio <linux-iio@vger.kernel.org>
> Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [STABLE REGRESSION] iio: hid-sensor-trigger: Change get
> poll value function order to avoid sensor properties losing after
> resume from S3
> 
> Hi Hongyan,
> 
> Can you check if the patch meets your requirement/needs for ISH?
> 
> Thanks,
> Srinivas
> 
> On Wed, 2017-04-05 at 16:21 +0530, Ritesh Raj Sarraf wrote:
> > 
> > On Tue, 2017-04-04 at 17:44 -0700, Srinivas Pandruvada wrote:
> > > 
> > > 
> > > Hi Ritesh,
> > > 
> > > Does the attached patch helps?
> > Thank you Srinivas. I tested your patch on top of 4.10.8 and it is 
> > working perfect.
> > 
> > Ritesh
> > 
