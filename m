Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953255;
	b=4dQOh37hhxvHs4/iBO9s6LWJjZQ2FeJ3NPA2HkzMrT9dfNC8khZJbWTNaowm5UkHQDbx
	 vQqyB6u3YiVmnk6Gb/SXoUUrQ1NST4dRkW9zKCSOqLCsV6pt+4dsP4jq4wbM5GI1D/Yd/
	 3enLF0Cw0f1YLx0b2mPppq+vjW08u3wN4AThDhR1LKJhQ0Wknq1Q7YOVNvjDSCjuGrK20
	 VE4rMuxgnODVAyRt/HPZo7BaI3m2DFHg1woC+dfQKPW5rbFDlS0Ff3C6bMN9pj5hVwFPF
	 NI/v4NYVFn99oApP5XZ8v7LuNY4DItj0qKCildfQfiVYuS/u8e1RoSiWLyfvWlUPm2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953255;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8m9VNbUHSsZjDpQXOJ7mijVQXVGihNqWgKsG2q6oToM=;
	b=Syb27TxAICDQ1JA38bZLSx5HZoCkUPUw2B176SE8BjtKsh9WNYkNEKH8ANEcZkrSzPSY
	 HCum4K+1207STTw3QBHTKYxpQi9DV4PzXJPQwdoARp9T+QmMmsogkyKM5VMmO2zv4gPi8
	 +MvU3QVJJfHzNSp3sPNojwvav2+IOZko0P7QhtNF7Jp5avZ3GM18zj66LdDlyxvAu0n46
	 QVDRawg9zTZyvVPFf4vx0tLuRDA9Xof5cLpxucOhqJozeXLDoaQFwTYyMqHA8KaNdwvbt
	 BnBhV8vToXAnhvGDADByR77JHhocKfQDZ79TEWkIUWYITvb3nceXCgf0XJ7CE6ds+vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGucc50w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9B606A329;
	Fri,  6 Nov 2026 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGucc50w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06BA1F008A3;
	Fri,  6 Nov 2026 08:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953254;
	bh=8m9VNbUHSsZjDpQXOJ7mijVQXVGihNqWgKsG2q6oToM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mGucc50w9st8H4l0SGhUi8RQ2B3Fs68ci/z0pIvRBmwrI94kJHnjUfeiq0Xy1y5Mq
	 j+ZkQOsNqWpMp5JV10RN9161jekIEkJbgpKE7Rkm+BSkHu80XgnHfTBwPKPzq7Xmri
	 w21DC1K+T33EjQ9AGoJ2mJ4QJaowgXJ4hWcmzbJw1lm9qog2miIczg5GFYLz7NOOQs
	 nxz+aIfYEkUxeZMAjmPVm7QH4xXalT6rXE9FJGe37dBrEdYsZSZYKy7riVJ7T//BkN
	 L5dATkITXdlNULnDtjrLoH4vFGUL7Jnkh1TrwsHi9JwXZ0WUZoUUn2iPn2/o5JKGeA
	 2sA476TGAOThg==
Date: Fri, 6 Nov 2026 09:20:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>, Joshua Crofts <crofts@kernel.org>, kernel@axis.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v8 1/7] dt-bindings: iio: imu: icm42600: Drop interrupt
 requirement
Message-ID: <20261106-jolly-hawk-of-spirit-d24cfa@quoll>
References: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
 <20261105-b4-inv_icm42370p-v8-1-b44eb96020b6@axis.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105-b4-inv_icm42370p-v8-1-b44eb96020b6@axis.com>

On Thu, Nov 05, 2026 at 04:48:49PM +0100, Kanak Shilledar wrote:
> The devicetree documentation for the invensense,icm426xx devices was
> documented wrongly. As per the discussion in the thread[1], the IMUs can
> work in polling mode, making the interrupts as not required.
> 
> Fix the dt-binding to not have interrupt property as mandatory. The
> driver will need to be fixed to not fail if interrupts are missing from
> the device tree. This will be done in a separate patch.
> 
> Link: https://lore.kernel.org/linux-iio/20261018034134.2bf170a0@jic23-hlaptop/ [1]
> Fixes: 22addefdabdf ("dt-bindings: iio: imu: icm42600: Add icm42607")
> Change-Id: I91ec65f6c00cbd6a48273ccd8cc476ee5266b995

Your work is going to worse direction - quality decreases :/.  This was
not here before.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

