Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302621E097;
	Thu, 28 May 2026 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978697; cv=none; b=Wg/KhpMxhiZeCv1GUaRAN4n8m8ddOZPnov3rxAGJ4IG1MSqrpwJUSSBFxRxA/C2WuUQ9YhFGr5n+f/pvBjAiKajznBin+M8Qy8w6Ocx4oDXRSs4FAn3EWBuTu1d9R3SIrcesUvogQmZQt6TP24WnvGM0NPN3N7UGnmOX512c7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978697; c=relaxed/simple;
	bh=Td1xJitxiDzzJJjDE5oddeOX21u+IW8VKtI0m5Za+tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H285VBYwUFH7wPUUR9VrE0z9dv/gPN7m5ERMZIdSleayb5bp8WbegBwoI5yhY6naua++2z1petbdtDa0QOt3cVUl/Z2BCNBLi21dKUIbr8wggKYtAMRAeFPCt92/eRTwoTwMMLjl6BrxZE9c4x+XCX31ToD8j+D5QBzH1w5jZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVIa14dI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVIa14dI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36D41F000E9;
	Thu, 28 May 2026 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978695;
	bh=FO62eDUGPK4apFj2VsqGTNxsf+/LmNvLwxs5aBAFjl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VVIa14dI+WA//zejpEFiygn92BJoNH+6nEilw708S86ieBDt4XTT520sd9f3KmGlO
	 9lRV+O7YVZk/ntstWffYM/C8v5HFo7Xcf20L2X75IfcwBaLjFOn5Yzg8AWixqGFijm
	 ZBV3IjvJ9MVLBXay1+3+9PqNdWBxVNo+qh5wEtB6rClZUkjgf+mP7FMsLvSwzsnesh
	 E9u3EQIrlt3D1gZ0TX+kqRUSvRoPC2vTgzcMx3+tbpjpmGF65qedMe30FTAaytyjHo
	 0hG47vqj9tWX+EKR4SUiVKqD/Xi4vTp0iEJ60TU4cvZyAKN83ME/ELKZ2boARcmbIo
	 G2GlM8G8cZcYw==
Date: Thu, 28 May 2026 15:31:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 7/7] MAINTAINERS: add Open Sensor Fusion IIO
 driver
Message-ID: <20260528153126.7be7c765@jic23-huawei>
In-Reply-To: <20260524085312.15369-8-kimjinseob88@gmail.com>
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
	<20260524085312.15369-8-kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 17:53:12 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add file patterns for the driver, binding, and protocol reference.
> 
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2c6d7927..9238701f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19977,6 +19977,15 @@ F:	Documentation/networking/oa-tc6-framework.rst
>  F:	drivers/net/ethernet/oa_tc6.c
>  F:	include/linux/oa_tc6.h
>  
> +OPEN SENSOR FUSION IIO DRIVER
> +M:	Jinseob Kim <kimjinseob88@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +L:	devicetree@vger.kernel.org
As noted, no need for lists. The appropriate catch all listings in 
maintainers cover IIO and DT-bindings.

> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-uart.yaml
Bring this in with the first file, then update as you add additional files.

> +F:	Documentation/iio/open-sensor-fusion-protocol-v0.rst
> +F:	drivers/iio/opensensorfusion/
> +
>  OPEN FIRMWARE AND FLATTENED DEVICE TREE
>  M:	Rob Herring <robh@kernel.org>
>  M:	Saravana Kannan <saravanak@kernel.org>

