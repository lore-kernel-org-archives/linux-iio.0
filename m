Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6119CD19
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487868; cv=none; b=Sbpgag5/OSbWbIe/ZXMlxST/z4+Ed5dTt/NDDqzMwAWoK3nlM9OU+2DkRHUZxYknTPFZSAz8LOz7V59DmNH7CCmqdfgOepExX1AGhZQ0NcRx6qWPtI77eia8vcUFoG7WMiGWduB+Ok0+2J1tDo45GKVSHYO0zz4Hf69P/AqDYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487868; c=relaxed/simple;
	bh=9Goybl8ewY5CB2jmSIFM5L9I3R8ff0hG98t9UEkb94M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+E42n7wWjDwPhjWm+DoIVsUA5oof/mNeKwQ57/i7R63i9VmdGkMuQAc0aA8D3jQXMtjR7Rl4YsBx+m5mk26ggS1mI2ght9au1X8MZf/dyRmkW+dEWFPJx4KSHHl8/B2SrLGUO+b/ES/Mwvh8uzYvVMJ1ilTCmw3semJVpNbGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSF/cnBU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSF/cnBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61250C19421
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771487867;
	bh=9Goybl8ewY5CB2jmSIFM5L9I3R8ff0hG98t9UEkb94M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PSF/cnBU+UF0D1RXibPpOH4xNt6leThzpd5Edj3SsqTIqj6MHsp+dQbjBYvcGkFrB
	 BpXhdw7eN94GIPMkpkORuTuEbTgd3BY+UBeojqOvd8pa7pgHO/0tmToxpt1foQpaUn
	 tQIjkGZAaq1yVU9DNbKU7uUK8t6FveEHHGq1OnlWq/OaKzrGlsgr5KSWeHS45Hsaxu
	 WN9r5BCCJ3Kj9zvKeFHRk9HaU67Dk4rfpwUSMCtDi5QeIOVQOEhTCEFHU3uLBTBHYn
	 p0zZ83HLbnHUaYhw4SsAc0638LM0s1ZB+rlDD8VA47fwB9CYxQkkb20kKP7ad6JT9R
	 kVl5S6PWIAeMg==
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-94acd026e45so178300241.3
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 23:57:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXh9iPu4IaKX2zgSYMeiyz807pjaWcqlRWBDssYo4o1oWybWXnJ8U2dpAL3TV/2Y0/NgCxVNUWOmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytOYxce4u3xQI9BXZJo8vHuveYoCiPboZEr+U2O579n7OZbgX+
	QBWLtBBJ+ATejOLU1N5+YVcMnQztGHYraj29FKwBoSADa9+8asJf/ZknLqqpVZ8CC94VduwpMK2
	Zeu1iy9coEXmeJF+kBJVB4386TT64Ju0=
X-Received: by 2002:a05:6102:c53:b0:5f1:51b1:488 with SMTP id
 ada2fe7eead31-5fe16fac317mr6344708137.44.1771487866322; Wed, 18 Feb 2026
 23:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218035549.17871-1-pranavkharche7@gmail.com>
In-Reply-To: <20260218035549.17871-1-pranavkharche7@gmail.com>
From: Ricardo Ribalda Delgado <ribalda@kernel.org>
Date: Thu, 19 Feb 2026 08:57:29 +0100
X-Gmail-Original-Message-ID: <CAPybu_24T+1e0C9Bw9GSv5ErmV4AZ-EZoEe5VZc8AZoCCJw8Aw@mail.gmail.com>
X-Gm-Features: AaiRm527eulDCTIzoZ1NLeTvpZEtSvSQ-SZTc5BC08MewRB_xipeF5l4ZXfXbnU
Message-ID: <CAPybu_24T+1e0C9Bw9GSv5ErmV4AZ-EZoEe5VZc8AZoCCJw8Aw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iio: dac: Fix typo in ti,dac7612.yaml
To: Pranav Kharche <pranavkharche7@gmail.com>
Cc: jic23@kernel.org, conor@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 4:56=E2=80=AFAM Pranav Kharche <pranavkharche7@gmai=
l.com> wrote:
>
> Fix a typo in the description where "Is is" should be "It is".
>
> Signed-off-by: Pranav Kharche <pranavkharche7@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Changes in v2:
> - Fixed author name format (added space, removed number)
> ---
>  Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml b/=
Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
> index 20dd13706..624c640be 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
> @@ -9,7 +9,7 @@ title: Texas Instruments DAC7612 family of DACs
>  description:
>    The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with
>    guaranteed 12-bit monotonicity performance over the industrial tempera=
ture
> -  range. Is is programmable through an SPI interface.
> +  range. It is programmable through an SPI interface.
>
>  maintainers:
>    - Ricardo Ribalda Delgado <ricardo@ribalda.com>
> --
> 2.34.1
>
