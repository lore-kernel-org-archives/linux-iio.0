Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55567 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932428AbcHXSnN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Aug 2016 14:43:13 -0400
Message-ID: <1472064189.28351.3.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/6] Intel Integrated Sensor Hub Support (ISH)
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Grant Likely <glikely@secretlab.ca>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        benjamin.tissoires@redhat.com
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 24 Aug 2016 11:43:09 -0700
In-Reply-To: <CACxGe6v6pDisF9FpKPJrojGS7qUn13xUUd-Uydr7B1701Y4szg@mail.gmail.com>
References: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <b81da639-0ec5-bb30-1f77-b71d8e7ad434@secretlab.ca>
         <CACxGe6v6pDisF9FpKPJrojGS7qUn13xUUd-Uydr7B1701Y4szg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2016-08-24 at 12:16 -0400, Grant Likely wrote:
> On Tue, Jul 5, 2016 at 8:42 AM, Grant Likely <glikely@secretlab.ca>
> wrote:
> > 
> > 
> > On 22/06/16 06:40, Srinivas Pandruvada wrote:
> > > 
> > > 
> > > Change log
> > > v2:
> > > - Overview in documentation show analogy with usbhid
> > > implementation
> > > - sparse errors for statics. Also pointed by Jiri
> > > - Clearly marking exported function header file. Clean up all
> > > exports
> > > unused inteface functions
> > > - Changed to tristate from boolean as pointed by Jiri:
> > > this required remove/unload functions
> > > - Prevent crash when ISH enabled on non supported platform
> > > - Break client.c to smaller part by seprating buffer allocations
> > > - move bus register/unregister to ishtp module
> > > - There is only one config symbol INTEL_ISH_HID, removed silent
> > > config for TRANSPORT and IPC
> > 
> > Tested-by: Grant Likely <grant.likely@secretlab.ca>
> > 
> > On an HP Spectre x360 laptop using v4.7-rc5.
> 
> Hey Srinivas. Any progress on this patch series?
Unless someone has major objection, they can land up in 4.9.
They will go through two different trees, I can ping you once I see all
patches in linux-next.

Thanks,
Srinivas


> 
> g.
