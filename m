Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52267 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbbKYXzb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 25 Nov 2015 18:55:31 -0500
Date: Wed, 25 Nov 2015 17:55:26 -0600
From: Rob Herring <robh@kernel.org>
To: Adriana Reus <adriana.reus@intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, pawel.moll@arm.com, pmeerw@pmeerw.net,
	lars@metafoo.de
Subject: Re: [PATCH 2/5] Documentation: devicetree: Add property for
 controlling power saving mode for the us5182 als sensor
Message-ID: <20151125235526.GA21218@rob-hp-laptop>
References: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
 <1448362792-5181-3-git-send-email-adriana.reus@intel.com>
 <20151125000130.GA21418@rob-hp-laptop>
 <56558466.9000001@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56558466.9000001@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 25, 2015 at 11:50:30AM +0200, Adriana Reus wrote:
> 
> 
> On 25.11.2015 02:01, Rob Herring wrote:
> >On Tue, Nov 24, 2015 at 12:59:49PM +0200, Adriana Reus wrote:
> >>Add a property to allow changing the default power-saving mode.
> >>By default, at read raw the chip will activate and provide
> >>one measurent, then it will shut itself down. However, the
> >>chip can also work in "continuous" mode which may be more reliable
> >>but is also more power consuming.
> >>
> >>Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> >>---
> >>  Documentation/devicetree/bindings/iio/light/us5182d.txt | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >>diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
> >>index 6f0a530..a619799 100644
> >>--- a/Documentation/devicetree/bindings/iio/light/us5182d.txt
> >>+++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
> >>@@ -7,13 +7,24 @@ Required properties:
> >>  Optional properties:
> >>  - upisemi,glass-coef: glass attenuation factor - compensation factor of
> >>                        resolution 1000 for material transmittance.
> >>+
> >>  - upisemi,dark-ths: array of 8 elements containing 16-bit thresholds (adc
> >>                      counts) corresponding to every scale.
> >>+
> >>  - upisemi,upper-dark-gain: 8-bit dark gain compensation factor(4 int and 4
> >>                             fractional bits - Q4.4) applied when light > threshold
> >>+
> >>  - upisemi,lower-dark-gain: 8-bit dark gain compensation factor(4 int and 4
> >>                             fractional bits - Q4.4) applied when light < threshold
> >>
> >>+- upisemi,continuous: This chip has two power modes: one-shot (chip takes one
> >>+                      measurement and then shuts itself down) and continuous (
> >>+                      chip takes continuous measurements). The one-shot mode is
> >>+                      more power-friendly but the continuous mode may be more
> >>+                      reliable. If this property is specified the continuous
> >>+                      mode will be used instead of the default one-shot one for
> >>+                      raw reads.
> >
> >I could imagine an OS may want to decide this on its own or use a
> >mixture of the modes.
> >
> >Rob
> >
> 
> There is no possibility of mixing them up (at the same time), so for example
> proximity cannot work in one mode and als the other.
> 
> The one-shot mode can only be used for raw reads (for example when
> user-space polls in_[proximity|light]_raw). If user-space wants to enable
> events (activate interrupts when certain thresholds are met - patch 5 of the
> series), then the chip has to switch to continuous nonetheless because it
> needs to be active all the time. So one work-flow scenario would be:
> 
> Consumer1 starts polling the raw interface - default_mode
> Consumer2 activates events - continuous mode
> Consumer2 deactivates events - back to default_mode
> 
> The only choice here is the default mode for raw reads, it currently is
> one-shot, this patch allows for continuous to be used if preferred.

Okay, then:

Acked-by: Rob Herring <robh@kernel.org>

> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
