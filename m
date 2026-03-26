Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5D334B662;
	Thu, 26 Mar 2026 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555055; cv=none; b=EwIplTUcuSY6IH0O2EQlpCw5auFzeyDoXMM7oDJTdu0MW2C23UUWYC84HM2Dy1NUHtoeu0wwyIq5m0L1zvhvo88H8JqXwp0IUd+gjDHsdZf0gK9XK2PgYcfHM3fbkP7pOljJlJDAY6CccvICrEBJmWEf7m4NahYYxshJD8QnouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555055; c=relaxed/simple;
	bh=JttQr6ja19BA2NJCGUge8nm+gAYUlqCp/BXQRJsn6tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCxC59vrNrQ2S+6U1yOSUIbbPujAlOyKBeiR2lcda7gR7ih0skchiVKwbjv4JwJImHo9lwxCbXgkyPNSMOUIiyxEcWPwg3ai4l5lt52/Zw20GempgoW+1rFVQ/PWrb2Ok1gtKjlxnChpS2481XXcpsOZfOpbEM3LDz16c81NKnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4rcr3ic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4rcr3ic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2D5C116C6;
	Thu, 26 Mar 2026 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774555055;
	bh=JttQr6ja19BA2NJCGUge8nm+gAYUlqCp/BXQRJsn6tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q4rcr3icHxtXNIKV8otrzy/M2ts4J7FKyHvTRDMiThEsg3UsHYnmzKAdkZBLAiAVw
	 eFF4tMoGYttH/02V0fPgQPIa3MhtZJ8b+yceKHAxBRXzsbt1N+72iLv03D+yauctUu
	 9LT26ZJbFPwjYlnM7WNeCBaos22MgZljhJCRLJKRfGjVy+9rUmnGupu+cy6fXs5B7y
	 8kuddANncDFk51SIdCZLxdHVk0ima/XP8697+mocmMMikvRi9Hqbr400A6GkIqfXOz
	 nkUwG1vWUhYvBsSGmWl9Gs6Opcb8SRt/6C3Lw8M1h5hApLzdIb4Wg10GlygF926V2O
	 Be9VPD/rBkL7Q==
Date: Thu, 26 Mar 2026 19:57:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nick Xie <nick@khadas.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com,
 martin.blumenstingl@googlemail.com, jbrunet@baylibre.com,
 dlechner@baylibre.com, andy@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: adc: meson-saradc: add support for Meson S4
Message-ID: <20260326195725.4be0624a@jic23-huawei>
In-Reply-To: <20260325070618.81955-1-nick@khadas.com>
References: <20260325070618.81955-1-nick@khadas.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 15:06:14 +0800
Nick Xie <nick@khadas.com> wrote:

> This series adds support for the SARADC IP block found in the Amlogic
> Meson S4 (S905Y4) SoC and enables it for the Khadas VIM1S board to
> support the onboard ADC 'Function' key.
> 
> There are no known hardware differences between the SARADC on the S4
> and the previous G12A generation. The S4 bindings utilize a fallback
> to G12A, but a dedicated driver match entry is included to ensure the
> correct part name is exposed to the userspace ABI.
> 
Applied patches 1 and 2 to the togreg branch of iio.git.

> Changes in v3:
> - Patch 1: Updated the commit message to explicitly explain why the
>   comment regarding the generic fallback was added.
> - Patch 2: Retained the driver patch and updated the commit message to
>   clarify that the dedicated match entry is kept specifically for
>   userspace ABI naming purposes.
> - Link to v2: https://lore.kernel.org/all/20260323013408.429701-1-nick@khadas.com/
> 
> Changes in v2:
> - Addressed feedback from Krzysztof Kozlowski:
>   - Updated dt-bindings commit message to explain the hardware compatibility.
>   - Separated the S4 compatible string in the YAML bindings to ensure it
>     correctly falls back to the specific "amlogic,meson-g12a-saradc" rather
>     than the generic "amlogic,meson-saradc".
>   - Updated the S4 SoC dtsi to use the correct G12A fallback.
> - Added Martin's Reviewed-by tags where appropriate.
> - Link to v1: https://lore.kernel.org/all/20260228065840.702651-1-nick@khadas.com/
> 
> 
> Nick Xie (4):
>   dt-bindings: iio: adc: amlogic,meson-saradc: add S4 compatible
>   iio: adc: meson-saradc: add support for Meson S4
>   arm64: dts: amlogic: meson-s4: add internal SARADC controller
>   arm64: dts: amlogic: meson-s4-s905y4-khadas-vim1s: add Function key
>     support
> 
>  .../iio/adc/amlogic,meson-saradc.yaml         |  4 ++++
>  .../amlogic/meson-s4-s905y4-khadas-vim1s.dts  | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi     | 14 ++++++++++++++
>  drivers/iio/adc/meson_saradc.c                |  8 ++++++++
>  4 files changed, 45 insertions(+)
> 

