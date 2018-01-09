Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from a8-200.smtp-out.amazonses.com ([54.240.8.200]:42660 "EHLO
        a8-200.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750911AbeAIVYC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jan 2018 16:24:02 -0500
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for
 BOSC0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux>
From: Jeremy Cline <jeremy@jcline.org>
Message-ID: <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
Date: Tue, 9 Jan 2018 21:24:01 +0000
MIME-Version: 1.0
In-Reply-To: <20171210182152.70ad8fbf@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/10/2017 12:21 PM, Jonathan Cameron wrote:
> On Wed, 6 Dec 2017 17:52:34 +0000
> Jeremy Cline <jeremy@jcline.org> wrote:
> 
>> Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
>> device. Check for a companion device and handle a second i2c_client
>> if it is present.
>>
>> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> The requirement for this is still horrible, but you have done a nice
> clean job on implementing it.
> 
> I'll let this sit for a few more days though before applying it.
> Probably next weekend if we don't get any feedback before then.

Hey,

I didn't see this land anywhere (I was looking in
git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git, maybe that's not
the right place?) and I just wanted to make sure this didn't get lost in
the holiday shuffle.

Regards,
Jeremy
