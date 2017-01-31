Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46067 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbdAaNlD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 08:41:03 -0500
Message-ID: <1485869863.5845.54.camel@hadess.net>
Subject: Re: Why hid-sensor-hub's IIO doesn't work properly in >= 4.3
 (possibly badly bisected)
From: Bastien Nocera <hadess@hadess.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Richard Hughes <richard@hughsie.com>
Date: Tue, 31 Jan 2017 14:37:43 +0100
In-Reply-To: <CAJZ5v0hYwyV+j+38rdqo81x0p5jWyLzHijYFY5RmnODzRUK0qg@mail.gmail.com>
References: <1484927552.21721.17.camel@hadess.net>
         <1485443735.5845.30.camel@hadess.net>
         <CAJZ5v0hYwyV+j+38rdqo81x0p5jWyLzHijYFY5RmnODzRUK0qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey Rafael,

On Fri, 2017-01-27 at 00:07 +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 26, 2017 at 4:15 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Fri, 2017-01-20 at 16:52 +0100, Bastien Nocera wrote:
> > > Hey,
> > > 
> > > TLDR:
> > > # first bad commit: [50ba22479c324c0d9dc8134d519dcba92d83a8a7]
> > > Merge
> > > back earlier ACPI PM material for v4.3.
> > > 
> > > hid-sensor-hub devices only start sending events through the IIO
> > > trigger after a suspend/resume cycle.
> > > 
> > > Other IIO drivers don't seem to exhibit those problems.
> > 
> > I had another go, trying to break into the merge commit, and it's
> > slightly more precise, but still doesn't make any sense to me.
> > 
> > # first bad commit: [3431e490b50356b56084305a2e93b3a980802b22]
> > Merge
> > branch 'acpi-scan' into acpi-pm
> > 
> > Any ideas? I'm running out of them...
> 
> The parents of this merge are 5af310a8ee70 and 1dcc3d3362b0.
> 
> Can you please check if the problem is present in any of them alone?

Both of those were already in the git bisect output:
# good: [5af310a8ee70dd6a588c8ee1d4487a230a7b7b65] Merge tag 'ib-mfd-base-acpi-dma-v4.3' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd into acpi-pm
git bisect good 5af310a8ee70dd6a588c8ee1d4487a230a7b7b65

# good: [1dcc3d3362b0c97e48290f7786be85b4cec2a147] ACPI / bus: Move ACPI bus type registration
git bisect good 1dcc3d3362b0c97e48290f7786be85b4cec2a147

Or did I do this wrong?

> If not, it is theoretically possible that the merge itself had
> introduced it (as this is not a trivial merge).

Yeah, I tried diving into the merge, but never managed to do so.

Cheers
