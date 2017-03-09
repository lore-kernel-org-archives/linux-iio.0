Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpauth-dc2.online.net ([62.210.16.40]:54974 "EHLO
        smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752797AbdCISZu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Mar 2017 13:25:50 -0500
Date: Thu, 9 Mar 2017 19:25:45 +0100
From: Miguel Robles <miguel.robles@farole.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Alison Schofield <amsfield22@gmail.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        linux-iio@vger.kernel.org, linux-iio-owner@vger.kernel.org
Subject: Re: PROBLEM: iio: dummy: Oops after mkdir
Message-ID: <20170309182545.GA15696@miguel-Z170X-UD5-TH>
References: <20170309143421.GA4623@miguel-Z170X-UD5-TH>
 <CAEnQRZAO0X9hW=kykM5wZrweO6Xukts-XUWWyQNJM0D3fJXh4Q@mail.gmail.com>
 <592203dd4ed4ded678778294008728bc@farole.net>
 <20170309173653.GA3675@d830.WORKGROUP>
 <20170309174049.GB3675@d830.WORKGROUP>
 <20170309180859.GA15190@miguel-Z170X-UD5-TH>
 <eb9e7974-a20f-cbda-8a00-af6a05389ea5@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <eb9e7974-a20f-cbda-8a00-af6a05389ea5@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 09, 2017 at 07:15:54PM +0100, Lars-Peter Clausen wrote:
> On 03/09/2017 07:08 PM, Miguel Robles wrote:
> > On Thu, Mar 09, 2017 at 09:40:49AM -0800, Alison Schofield wrote:
> >> On Thu, Mar 09, 2017 at 09:36:54AM -0800, Alison Schofield wrote:
> >>> On Thu, Mar 09, 2017 at 04:59:39PM +0100, miguel.robles@farole.net wrote:
> >>>> On 2017-03-09 16:41, Daniel Baluta wrote:
> >>>>> On Thu, Mar 9, 2017 at 4:34 PM, Miguel Robles <miguel.robles@farole.net>
> >>>>> wrote:
> >>>>>> Hello all,
> [...]
> >>>>>> CONFIG_IIO_CONFIGFS=m
> >>>>>
> >>>>> Do you also have CONFIG_IIO_SW_DEVICE right?
> >>>>
> >>>> Yes, and the value is:  CONFIG_IIO_SW_DEVICE=m.
> >>>>
> >>>> Thank you,
> >>>> Miguel
> >>>>>
> >>>>> Will try to have a look at this asap.
> >>>>>
> >>>>>
> >>>>> thanks,
> >>>>> Daniel.
> >>>
> >>> Daniel,
> >>> You probably saw, but just in case...
> >>> I verified that the process, including the above mkdir, is working on
> >>> 4.10-rc3.  (So, I'm relieved the Outreachy applicants won't start
> >>> hitting it.)
> >>> alisons
> >>
> >> I see Lars' patch! 
> >> It worked for me because I used CONFIG_IIO_CONFIGFS built-in.
> >> alisons
> >>
> > I applied Lar's patch and now the command is working fine!
> > Even if I do not understand very well the patch. I mean, I always declared
> > CONFIG_IIO_CONFIGFS, so the code should be normally always compiled.
> 
> What the kernel build system does is when the symbol is select as built-in
> (=y) it does `#define CONFIG_CONFIGFS_FS`. When the symbol is selected as a
> module (=m) it does `#define CONFIG_CONFIGFS_FS_MODULE`. The IS_ENABLED()
> macro basically checks for both and evaluates to true if either of them is
> defined.
> 
Now I undestand :).
Thank you for your clear explanation.
Miguel
