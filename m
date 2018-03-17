Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeCQVOw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Mar 2018 17:14:52 -0400
Date: Sat, 17 Mar 2018 21:14:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <john3909@gmail.com>
Cc: linux-iio@vger.kernel.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com
Subject: Re: [rfc] staging:iio:meter: IIO ABI issues
Message-ID: <20180317211447.1e91b1c9@archlinux>
In-Reply-To: <6BD44826-5F90-4377-8C15-230ED4014B27@gmail.com>
References: <6BD44826-5F90-4377-8C15-230ED4014B27@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 15 Mar 2018 21:00:11 -0700
John Syne <john3909@gmail.com> wrote:

> Hi Jonathan,
> 
> Since this is probably doing to require a few rounds, I have created a new thread for this issue.
Oops, I should have read on a few emails. Replied to the previous version in the main
thread.  Sorry about that!

Jonathan

> 
> I have been looking at the IIO ABI docs and if I understand correctly, the idea is to use consistent naming conventions? So for example, looking at the ADE7854 datasheet, the naming matching the ADE7854 registers would be as follows:
> 
> {direction}_{type}_{index}_{modifier}_{info_mask}
> 
> AIGAIN	-	In_current_a_gain
> AVGAIN	-	in_voltage_a_gain
> BIGAIN	-	in_current_b_gain
> BVGAIN	-	in_voltage_b_gain
> —
> How do we represent the rms and offset
> AIRMSOS	-	in_current_a_rmsoffset
> AVRMSOS	-	in_voltage_a_rmsoffset
> —
> Here I don’t understand how to represent both the phase and the active/reactive/apparent power components. Do we combine the phase and quadrature part like this
> AVAGAIN		-	in_power_a_gain				/* apparent power */
> —
> AWGAIN		-	in_power_ai_gain				/* active power */
> —
> AVARGAIN	-	in_power_aq_gain				/* reactive power */
> —
> Now here it becomes more complicated. Not sure how this gets handled. 
> AFWATTOS	-	in_power_a_active/fundamental/offset
> —
> AWATTHR	-	in_energy_ai_accumulation
> —
> 
> 
> Thinking about this a little more, perhaps only the attributes that would be used in a user space app need to be this descriptive. Let me explain. Most of the registers on the ADE7878 and even more so on the ADE9000, would have nothing to do with the user space app. Most of these registers are used purely for configuration, settings and calibration.
> 
> For these registers, maybe we should use the register name as the modifier. For example:
> 
> AIGAIN	-	register_AIGAIN
> 
> For measurement registers, we adhere to the traditional naming convention:
> 
> AIRMS		-	in_current_a_rms
> AVRMS		-	in_voltage_a_rms
> AWATTHR	-	in_energy_a
> AFWATTHR	-	in_energy_a_fundamental
> AVARHR		-	in_energy_aq				/* I still have a problem with this one */
> AFVARHR	-	in_energy_aq_fundamental	/* See the problem here? */
> AIMAV		-	in_current_a_mean-abolute-value	/* I’m having a difficult time trying to make this work */
> 
> When I look at the ADE9000, the functionality is even more complex, so I’m hoping everyone can offer suggestions on how to resolve this.
> 
> Regards,
> John
> 
> 
> AVARHR		-	in_energy_aq_accumulation
> —
> IPEAK		-	in_current_peak
> —
> 
> I’ll leave it there, because there are some even more complicated register naming issues.
> 
> Regards,
> John
> 
> 
> Regards,
> John
> 
> 
> 
> 
> 

