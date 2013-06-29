Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43017 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab3F2MX2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2013 08:23:28 -0400
Message-ID: <51CED1BF.8070200@kernel.org>
Date: Sat, 29 Jun 2013 13:23:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: add DAC 500kohm_to_gnd to possible powerdown_modes
References: <1372023020-18742-1-git-send-email-pmeerw@pmeerw.net> <1372023020-18742-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372023020-18742-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/23/2013 10:30 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
applied to the togreg branch of iio.git
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2e33dc6..0af1af0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -351,6 +351,7 @@ Description:
>  		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
>  		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
>  		100kohm_to_gnd: connected to ground via an 100kOhm resistor,
> +		500kohm_to_gnd: connected to ground via an 100kOhm resistor,
>  		three_state: left floating.
>  		For a list of available output power down options read
>  		outX_powerdown_mode_available. If Y is not present the
> 
