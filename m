Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238E37C0F8;
	Mon,  4 May 2026 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910535; cv=none; b=bfYK/BLhtWz+OlQPZ64u9eNb0f5ANCessg2ktSS2ryfneua4PHcGZQL6rwHa7/bYcgs3cv3L4gDG2ZkK/tNQ2Y3j7AIjLBUA2vgfo1QZxJ1G2bAQ4i90kCw7skDm7d9nh+JfdCHNrI6rdeBRrQf7YZAE8pJqPp94pc/5RB73LN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910535; c=relaxed/simple;
	bh=mTEeXh711WtBdL0ctv+LrfudDU57QklEIWOvmYihlas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caIc/105g15PAuCZk1P1exOhrzCw6wQV4BTSC9b3yA27aWsz15UKtHiLZPTLTFjK7nJ8ynnkxfkICJ2j5om+mxKEWKkqHJn8n4ajRF6/Tbu2TInGBm3BWfDcxtz8zHLcmWZkpioXEywZptJj5BHlfopStvE24iATEQHcoSrDTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVr3lpMQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVr3lpMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D08C2BCB8;
	Mon,  4 May 2026 16:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777910534;
	bh=mTEeXh711WtBdL0ctv+LrfudDU57QklEIWOvmYihlas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YVr3lpMQhG5A6l7utl7kIJsMk1/5KyrdNJusqdZHk2fiPQdjG3n9HEIYorqYdACBW
	 7iIlTKpSSBp0a29ial76nahJOiMPkWDcyCXigfwHZlJYvYddtUCt8YMkFeRybl4Zfz
	 NPSabACktAqDaDyAT9gdjF6obdg3oJUPLSbiQ6wpwulxu2gjO8q5IydLZmUaFwznPj
	 t/CspYMet3+BZENeERxsQ6T+H4Gbmv/bkuec1MhP0JSAJJYsShLtGyIggqR7jk63pJ
	 opGnvW8J7URX/IePdBKsFNOCVMTP6HiEdzsPNDO2XTE/Woa8Ktg1MNbwr7OCQIFCNF
	 SBljvklplWZPA==
Date: Mon, 4 May 2026 17:02:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/11] iio: adc: hx711: add support for HX710B
Message-ID: <20260504170152.4a96043b@jic23-huawei>
In-Reply-To: <20260503120949.80292-12-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
	<20260503120949.80292-12-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 May 2026 17:39:40 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> interface but uses trailing PD_SCK pulses to select the active mode.
> 
> Model the HX710B with variant-specific channel tables and IIO info,
> track the active channel across conversions, and use the fixed gain
> value when computing scale.
> 
> Also update the adjacent Kconfig text, file header, and module
> description so the driver text matches the newly supported variant.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Andy did suggest waiting for open questions he'd raised to be
resolved in the v5 discussions.  That would have save a little
time on this patch at least.  See what I wrote there.

Thanks,

Jonathan

