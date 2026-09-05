Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A8E2FC00D;
	Sat,  5 Sep 2026 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569439; cv=none; b=qqIj5PIHydFwyLv0n5j3ZToXnR7P6+uEAJM13Wb2DV7bdimitnvLOel8L8WV6wkYWtL1VSI/0HkNzdNbSBMiVr9dER25uOLJG1piucoZHpl0qTw9PQlmlhdiebebXvDz6nF9kYuCVL6Xudl6sGH1eIwPTp66eYkDYgfNbWKiTDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569439; c=relaxed/simple;
	bh=FRmn6v/su59D1UBWg8sgCFbizo1N5J1yXEeRA2oRzZU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rZrVDAXrVqzUKaTE625pCj0CDROoaBqeBEeBep3jePrUQKQNFzk0Enm1ND7JlWccvPCk2YN3dS9QwRzXyoJ8TOX1mu1zPZ1WG5WNX9L1TTWL0+VHNN7V8au9NjGKqiCsxE1d3H1Vsnwq8vbo8Xy316ILmotFFyDur16UiMok1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOywYq8g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOywYq8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683FC1F00A3D;
	Sat,  5 Sep 2026 00:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569437;
	bh=ttVQpWj8u9GE8oMgnpNNLiJ1MGSBqX+eaN7VcdJGEm8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JOywYq8gb+LJf6Jp097PEZM/KIiT3tX1yeJ3eidbVo27+lxaMDPLJHXqfsUZ5yhQ8
	 RKfx8L6s+O/zxrF7gSRW+AJ/Cm9E7ZVh6o+zVsnCvlp6W70uP8h2jcjlsstb20vfC6
	 JxzMLU1bxAT8GQ00OCkTM7NLng987LC7Ia10t0IalFE7bokh7r7pWWhulxTeNKlKqs
	 eX43l+rspDsKKFHFRRO+krytc3zLf1tuQ6lojOilZjG7SBN4C+WUvh0pMjmQoczPhv
	 YqnpSP6OV6WCFpZdnp0ZZArPB0fB1W687REQ9DfSBoiJgHOlB5RAZErLCuYMlICvA2
	 QhzWYvzz4pS4w==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 5/5] iio: light: stk3310: support the Sensortek
 STK36C61
From: Jonathan Cameron <jic23@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Kees Cook <kees@kernel.org>, 
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
In-Reply-To: <20260901005114.203062-6-jorijnvdgraaf@catcrafts.net>
References: <20260901005114.203062-1-jorijnvdgraaf@catcrafts.net>
 <20260901005114.203062-6-jorijnvdgraaf@catcrafts.net>
Date: Sat, 05 Sep 2026 01:50:17 +0100
Message-Id: <178856941779.3402141.15390844295532043717.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2413;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=FRmn6v/su59D1UBWg8sgCFbizo1N5J1yXEeRA2oRzZU=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqm2dN8+iGpUMUKvc8pCGh323rplt9VV0o4JsU8
 vIakFNfm5iJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaptnTREcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiFLED/kB4oAST9hoAOPWSBGNdEPKdVh6OOlkEkMfa0lYxImv/RX
 e7Lma9NaILhaKiE4F4QA3ZxPuAied4NDZRYOThnGWSt6zps6JUGESdWRFLarCFS/npEmhZg01hJ
 arDrXAiCzcMCrmc470hAnbvGo/aklnYtBJpgzG9zS93Mm7IAqlvmSuYnVBSK9KZCteGZtnROsqA
 aG1z8CUlKP5l8TQPtU4zzNllKMAUac6JgIU9vxv3BwqoM/8BZty2bSi40DezW8WuKoSjuTgmpGP
 XbUPwm0TlyiuZa8fWT0jn3lZw1GWJbFBim853NF86FV0txXD6SvTeoaFyCDfp2fO4DaOyeue17h
 /rlrJRD506ansWvuL+c/T7nLKIlsQeS2X1FvIGWNp9Ad9MgWQQleAVKth+ABprQwJDCRxL72uba
 bAaYh6tzUt3TA4+g+1D7P3Qaey8Em7MugQvKSzemV4K+gwV2Hu8u15KmOJnSfH96mwlPCZl23aO
 gYcdE9Usiq9wZq0a4IekysL4qsttFP7bIQNJ6AiSLx/LbX0kRPI/RTQwkherAgYG+hvG7wQLTBB
 bGZd45D1DxDfFN9hhjMCNKxpsTEIXsBjg4PIG5RLWs6OmQsVe3Deqh47eGnOkPLOYp0CshkWIjr
 HeQaI9q6QoQHyb+ha/i5LZDj6ade9mcq+lqKT7A==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
> colour sensor. Its register interface is compatible with the feature
> set this driver uses. Add its chip ID to the known-ID list and the
> device table entries.
> 
> Whenever the ALS engine runs, the chip also measures four colour
> channels: red, green, blue and clear, laid out directly after the
> ALS data as 16-bit big-endian values.
> 
> R, G and B are gained by the same ALSCTRL gain field the illuminance
> channel uses, clear by its own gain field in the GAINCTRL register,
> and the whole colour block integrates over the ALS integration time.
> Expose the channels with per-channel scale and a shared integration
> time, as suggested by Jonathan Cameron for the green channel.
> 
> The scales reuse the driver's existing gain-only table: green equals
> the ALS data, so its scale must read identically to the pre-existing
> in_illuminance_scale.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>

So there is a Sashiko comment on this one. It's an exisiting issue
in the tear down path so out of scope for this series.

In general we probably need to look at the various things that
might get called on late running or spurious interrupts to be sure
they are safely dropped.  Anyhow, yet another thing for the todo list.

>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a4f5595722ad..08a8de215814 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio

We'd normally do a core ABI docs update in a separate patch, but
it is such a small one I'm not going to ask you to respin for that!

> @@ -507,6 +507,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_z_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_clear_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_scale

Thanks

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
