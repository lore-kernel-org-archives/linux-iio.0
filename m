Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753127AbcHXVOZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Aug 2016 17:14:25 -0400
Date: Wed, 24 Aug 2016 23:14:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Grant Likely <glikely@secretlab.ca>
cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        benjamin.tissoires@redhat.com,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] Intel Integrated Sensor Hub Support (ISH)
In-Reply-To: <CACxGe6v6pDisF9FpKPJrojGS7qUn13xUUd-Uydr7B1701Y4szg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1608242313540.22028@cbobk.fhfr.pm>
References: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com> <b81da639-0ec5-bb30-1f77-b71d8e7ad434@secretlab.ca> <CACxGe6v6pDisF9FpKPJrojGS7qUn13xUUd-Uydr7B1701Y4szg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 24 Aug 2016, Grant Likely wrote:

> >> v2:
> >> - Overview in documentation show analogy with usbhid implementation
> >> - sparse errors for statics. Also pointed by Jiri
> >> - Clearly marking exported function header file. Clean up all exports
> >> unused inteface functions
> >> - Changed to tristate from boolean as pointed by Jiri:
> >> this required remove/unload functions
> >> - Prevent crash when ISH enabled on non supported platform
> >> - Break client.c to smaller part by seprating buffer allocations
> >> - move bus register/unregister to ishtp module
> >> - There is only one config symbol INTEL_ISH_HID, removed silent
> >> config for TRANSPORT and IPC
> >
> > Tested-by: Grant Likely <grant.likely@secretlab.ca>
> >
> > On an HP Spectre x360 laptop using v4.7-rc5.
> 
> Hey Srinivas. Any progress on this patch series?

The HID part (with patch #5 omitted) should be in linux-next through 
hid.git already.

-- 
Jiri Kosina
SUSE Labs

