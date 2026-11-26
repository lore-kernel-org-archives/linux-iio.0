Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699095;
	b=bw6ytyNzixzw0TiTzZj74r2Tno3UsnO12noNOLth5fK3gyGifEufqgU26WM6RL2cLxRc
	 oNwZU6ru/IPIZFLGFUFTb+Sgfj0ZZOBjO4dzvIL6ZmeOgr4t0OlCf+y4h7JfJSY8BzhUR
	 hbH8ymKEx0elZo4hcqvwy62bYSVuJY6T3uYbUJqRBooLyDGGLXZCmzUbN/Pv1KS4Bes/q
	 T2rR8K9+dq4Bux7rsox+8NJ9xprTuR/jradwaali7DQlvCQipFj0AidpyvGLoXEVRio0r
	 huJPGfLneTICIW2RXg9Za9pAJCnSPDTN2OK+Y2egorn+CMNbMWyY8apvEnnCBa0arzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699095;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WPjxXYBHEJYB3gXnjvRAbfNZ6Cal7DKX9EGTmFqK2VU=;
	b=rTlAyzvvYWhxMCJYSjQO49thlJos+HLqL1Oy56zuuIC887MjR4Ai5oZBiQ6PX185w4fH
	 k75QOj6DKpfWWizety1HRbs7ei0erAjyeq1HL4fMB3S3L2XgPMucWIlLv8bvumIWptNXx
	 T9vbTN0syUnbwqTdjyvDGAFYoNzcR2+1LQZs2xXIGSuBbhVC4UV7GZo4bWFcle+yf8NtJ
	 4gn/cp3vGL4KlSjeqSxj0tZ1BjXbAyJf79yDp30WWTXiGuEqjKu5J+SqwzZtufnZfftK5
	 gEY+jh40rnDPGEl6EzXlYXPNRmCX4QNOwa3lm0RexHAy8URCyTyahPEb7IPm8K3MMpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kVyoUeiy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9867606A31C;
	Thu, 26 Nov 2026 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kVyoUeiy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1891F000C4;
	Thu, 26 Nov 2026 13:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699095;
	bh=WPjxXYBHEJYB3gXnjvRAbfNZ6Cal7DKX9EGTmFqK2VU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kVyoUeiyNrJUH3bdZyZufCBO+rJuXlvWlBGNAZo+WNo6MTf+knBZqlBx1N9wS9e3Q
	 Oux0oQPJpQbP7k98CRhgXCuMtxpDmKgszPlAJT+voo7NK7ESG/FikgXhrF+hkIijKo
	 x5fVCYYxW/tJxtFrPtvq0iOT3pPFrEypwJjteuts8pfGIIGhgRSn+/M2D31PoFtYt3
	 YIdCfC5m+Q0/901/bwTQdx7y7BQPlB3Taz+m2Mcxq0W09INa3xkMTr9RE39qNYv+oh
	 6h35XmrmGiCQH/2IQc+SmLnp63TABW7gxsbCpNPJ9lAof7bFe2tuBe7upsOM14K7zn
	 1CcK+5/uiWbJQ==
Message-ID: <e11d0e34-93bc-4952-8543-3bd2dfd82e8e@kernel.org>
Date: Thu, 26 Nov 2026 14:18:11 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/7] iio: pressure: dps310: use min() instead of
 min_t()
To: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
 <20261126121331.10438-4-zoone.rupert@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261126121331.10438-4-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26-Nov-26 13:13, Rupesh Majhi wrote:
> min() accepts s64 and int, both signed, so min_t() and the cast are
> not needed.
> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts

