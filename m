Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476F26F29B;
	Tue,  7 Jul 2026 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783390154; cv=none; b=H2XV09OTy3TWJf78sZaCSWqIFgF89htZYmPmsZkoGPViHOkVDzxYwk51rjt7Vm1olWADdte3jlEjCHx0f4Lv97P+ESDKP6ldmaSwfMtBVyXrjcXBD0z0KLFVtqdHqC/R4k4WTF7NkGx14pN9Lu5+MEx/RMiq2+KDLClq70+9CVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783390154; c=relaxed/simple;
	bh=FVtVAaSuJTY7vHYjip/kdPM2L3aNFrm1fPM3MEPpF3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oS5yss+Zjsjaval64OJgOwFgA50B3E3KqNcv/hc8OMKvSnDq/wYRWHw69f21YaFIL2uZ++2Cip70aka7FY0xD9t8KQIUiLsqCsLA2OyWrbvhKxVKhs0pxTS5IA9+TDyGdNJFWzDFxNuwKHoACDM4yGb5Td7z7WetmeyV774JIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COKZ92la; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COKZ92la"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261E81F000E9;
	Tue,  7 Jul 2026 02:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783390152;
	bh=X+GavMHJxo/C0eP06aCFkaFhtwTiuGsoQw2pkGdhRkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=COKZ92laQhl1csIEkPD6FHIBolJNsjd27MEkSM1QUkHmeCLiZzXhiSbxzh+80bodW
	 Eo9LRa5hhnpXN+NLjvJp085C/ja6Wp0kSwiGNSJNmoRY0VMOuRk0HtTHPWoPRWbzUm
	 wPYcrpPXbnkCqJcf8CqOEAQDZDMcWc3rQ5UWFuqQRmtv8Rk8ky7xVSrz5KvRasbxHi
	 UMVdqAoIRjPMxTVHGtxZ0RjWrfxUPIfEr2WQN3lodMRh6jyJykB/lLCHPIfb70YEsK
	 myxcIfD0CkLgRK/xGp5L/yinB0F6Jm8aVbqq76O0bX9Fu1ja5G/x8EiONakVuWhlPY
	 LEGrsrv//djCQ==
Date: Tue, 7 Jul 2026 03:09:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, Fabio Estevam <festevam@nabladev.com>,
 linux-arm-kernel@lists.infradead.org, Andy Shevchenko <andy@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] dt-bindings: iio: adc: rockchip-saradc: Add
 RV1106 compatible
Message-ID: <20260707030907.1502dba6@jic23-huawei>
In-Reply-To: <20260706195818.3906949-10-sjg@chromium.org>
References: <20260706195818.3906949-1-sjg@chromium.org>
	<20260706195818.3906949-10-sjg@chromium.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jul 2026 13:58:05 -0600
Simon Glass <sjg@chromium.org> wrote:

> Add the compatible for the SARADC of the Rockchip RV1106, which is
> compatible with the RK3588 variant.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> index 6769d679c907..c3bb03dc4853 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> @@ -24,6 +24,9 @@ properties:
>        - items:
>            - const: rockchip,rk3576-saradc
>            - const: rockchip,rk3588-saradc
> +      - items:
> +          - const: rockchip,rv1106-saradc
> +          - const: rockchip,rk3588-saradc
>        - items:
>            - enum:
>                - rockchip,px30-saradc

Follow the style of this one...  I.e. use an enum and
then a const given both the rv1106 and rk3576 fallback
to the rk3588

Thanks,

Jonathan


