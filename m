Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B863A0B23;
	Mon, 20 Apr 2026 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689551; cv=none; b=Bqoh2c7Q2NokhKxpdiEkQsk/8eaYnzhXtJ6Hb7KHZROnxwEcBOE1uuFvIZEtB9P6IrXS7H9AqGXFM+OWS3hEJHC5wDu9taaSIVatJhRGlE/KDe6UN/xuPPDZYzQb4QF2mdpQCM2Mi/dEsYOobcVEr33uPbx+vh814+ggOzOUTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689551; c=relaxed/simple;
	bh=TRCb85quAb1Jds1qq2otmPssvYv2USQ9yjh0heKXfyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izqjyd2O5OnCpRK/ZeliEZgpbjkLaLGbuo8/u3UmneEagrPa7sq9gWZpCLHgNHGSGibifs6UHXKl45rpXH0pKpPHhVGQ1sbE1vUCbwmjhZV+6CiK5PlRXbpzF/SdAIufbQ7fJPWZz/coEU1bwUubic9KXwp+FqnrLTmeF9IBvFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNdNYyzT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNdNYyzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB08C2BCB7;
	Mon, 20 Apr 2026 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776689551;
	bh=TRCb85quAb1Jds1qq2otmPssvYv2USQ9yjh0heKXfyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RNdNYyzT2UbESTygKadw7B97rSGCznI60gv46bQ/UsYzCarkQiGRdVDLQHyQ90ez2
	 RqExQkQt5V6F3jOhESpQWJy0rnAAKejDckiOoAXXeTr3H4UBtG62aMLvffVO+PPGm/
	 8d1e291fmL5JxH34ZNhItJ3u2OeDQg19kTdcBA+bf0BzV3K4zgPE3W0rWpsqFQFzxB
	 HspLoYwRQwN6kQyZXNXWXWsgpVS8jJgU+LXwvTQIEJ/k3PrSjbYwG5rS5kh19XAH1f
	 jHC0PizFDrVMvuAqy8gTLIxLUbh2iZlG/S5QHjEuSJaadTcWQJyhrzN72T6tyDUk4k
	 0wTSZk0oWezrw==
Date: Mon, 20 Apr 2026 13:52:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Harpreet Saini <sainiharpreet29@yahoo.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Bjorn
 Andersson <bjorn.andersson@oss.qualcomm.com>, Marek Vasut
 <marex@nabladev.com>, Kael D'Alcamo <dev@kael-k.io>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: light: Add PixArt PAJ7620 gesture
 sensor
Message-ID: <20260420135221.2af64921@jic23-huawei>
In-Reply-To: <028a5407-e0c1-438b-b124-55df8e5fda92@baylibre.com>
References: <20260413000308.7618-1-sainiharpreet29.ref@yahoo.com>
	<20260413000308.7618-1-sainiharpreet29@yahoo.com>
	<028a5407-e0c1-438b-b124-55df8e5fda92@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 09:25:19 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/12/26 7:02 PM, Harpreet Saini wrote:
> > Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
> > ---
> > This is part 1 of a 2-patch series proposing a driver for the PixArt
> > PAJ7620 gesture sensor. This patch adds the Device Tree bindings and   
> 
> Gesture sensor sounds like input subsystem, not IIO.

There is one gesture sensor in IIO but that was driven by it
being a combination of that and a proximity + ambient light sensor.

drivers/light/apds9960.c

It seems there is already a series for this one on the input list, so I'll let
any further discussion and review happen there.


