Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35A48B38B
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990556; cv=none; b=G1gOwrGEITenurEKnSWCW/NwxzQsJzzX0E+uojYwZ3rQsPl0F6/8ZwE0wjCLzEtS2X0wTHHog9bSnhNlwfAxRL4bRPahb7WLx1iisnP8KRutvsdrHr3TbGepjgWQytleAk/Qwffcm66a7JpJLH94kGE6YnKu1A5gDU8oCMQlzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990556; c=relaxed/simple;
	bh=O0SDNvnCc85hgqvB/wn6qXlzpmd0XHpMb4fgdIVrnEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxUxm/NCVpBNbGQXKr1AjkqJDFjD3AuqgD7smdRDeeZHZiFjy8mnMPpYQrKTU3H9XZKz0++t5iFuD9vUV13etYrDk72Lf7o53Nackcc5CBkeSoAH3iu94coxbQPC1yAAOZod3vGuBlr4vsJeZxUKVfduM0SOH70MPdvvBUmdU5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKtS4KXy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKtS4KXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1052DC19425;
	Wed, 21 Jan 2026 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768990555;
	bh=O0SDNvnCc85hgqvB/wn6qXlzpmd0XHpMb4fgdIVrnEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKtS4KXyu/cXTsSGPh0hZQeKM8HT9U3/kYip6wXB9gRTtg9gsoYb+OpcSL78CZuo6
	 EBNL1UM8HuCXLuQZk6wUmliGTV01h3V0LHoxQGyJjSlYCS9p/ftjjeyeiQ5/iWVFVr
	 PSVoX04TZJ+5fePpumNOfEs5kwaL91aSevSpZiIfzA5oQHpBiCNhFukwMg+4tTMxGA
	 LrhZ+4xplrOWkGNZwZOrwiJ9slDYKOgFqyVxLfEzg62SMUeaYEQZ2yEwYZWlAdPOgb
	 9UTEXzvu0nnzDWFjpTbzLbMEpbI2XkQbfMWDo8g7eNIFnNxl4vXDeORhPcblFXpySQ
	 81b7IecFU1EIA==
Date: Wed, 21 Jan 2026 10:15:52 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jic23@kernel.org, nvaccaro@google.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: Allow enabling/disabling calibration mode
Message-ID: <aXCnWIkTLauLbBKa@google.com>
References: <20260119074928.1334489-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119074928.1334489-1-gwendal@chromium.org>

On Sun, Jan 18, 2026 at 11:49:28PM -0800, Gwendal Grignou wrote:
> calibration was a one-shot event sent to the sensor to calibrate itself.
  ^ C

> It is used on Bosch sensors (BMI160, BMA254).
> For light sensor, we need to stay in calibration mode to run tests.
> Accept boolean true and false (not just true) to enter/exit calibration.
> 
> Check "echo 0 > calibrate" is supported.

I can somehow understand because the patch is small.  But I believe the
commit message should be rephrased.  For example, if we only need to "stay"
in calibration mode to run tests, why do we need to add the patch for
disabling calibration?

> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 69294f79cc88a..d363d60bb8a36 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -2598,13 +2598,19 @@ struct ec_params_motion_sense {
>  
>  		/*
>  		 * Used for MOTIONSENSE_CMD_INFO, MOTIONSENSE_CMD_DATA
> -		 * and MOTIONSENSE_CMD_PERFORM_CALIB.

Missed a period here but that's also what current ec_commands.h [1] has.
It should be fine.

[1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h#3158
