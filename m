Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58491 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932553AbcKIPKE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Nov 2016 10:10:04 -0500
Date: Wed, 9 Nov 2016 16:06:29 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Rosin <peda@axentia.se>
cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Slawomir Stepien <sst@poczta.fm>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 8/8] iio: envelope-detector: ADC driver based on a
 DAC and a comparator
In-Reply-To: <ac908a97-77b8-046a-a0e9-74cc97f56c9b@axentia.se>
Message-ID: <alpine.DEB.2.20.1611091605090.3501@nanos>
References: <1478606339-31253-1-git-send-email-peda@axentia.se> <1478606339-31253-9-git-send-email-peda@axentia.se> <alpine.DEB.2.20.1611081630450.3501@nanos> <d8237286-d2ff-3146-d718-f54d05b0101d@axentia.se> <alpine.DEB.2.20.1611081809320.3501@nanos>
 <1c104a31-6c66-9537-9b90-ede58c8e1a92@axentia.se> <alpine.DEB.2.20.1611082146560.3501@nanos> <ac908a97-77b8-046a-a0e9-74cc97f56c9b@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 9 Nov 2016, Peter Rosin wrote:
> On 2016-11-08 22:47, Thomas Gleixner wrote:
> > I don't think you need extra race handling with that, but I might be wrong
> > as usual.
> 
> There's obviously no way to determine which of the timeout or the
> interrupt that happens first without some race handling, so I don't
> know what you mean? If the timeout happens first, there is also a
> need to handle late hits from the irq that might come in during the
> preparation for the next step in the binary search. It gets messy
> quickly compared to the simplicity of the current implementation.

Gah, forgot about that timeout thingy. Fair enough.

Feel free to add an 

Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
