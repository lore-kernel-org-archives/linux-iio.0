Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4837E5C5
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791740044; cv=none; b=MnubOUfC4s2Gbuub/z//Dmck0AcjfEpKmBQiYssLL3cwQSGV4zxF7d30e4FIc83FHUxXQKJH75Q1q0EE/2s0lwrSwkMY7tz1J4KyzTD5xohdS1OqMQLadcDwtzFXivNNCXl0g6haNYxspovqvRDuQJ4IY0e+3ZobmUg1917N0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791740044; c=relaxed/simple;
	bh=CJLr4pB0xXQD8PTWTHC/kN+Z90gir1+n4RTjMZ5jg+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVhugeplqIVo74qbr3xGfIlKUtcIUdzJ363IxR27F70rAEhPXfoHsXdmPXRyH/en1GMPba9kXOIcelap/o8DW+YYGKUbDQqKjExZLpHgYqcc+Ka2YbEKZMxgBOeKwl9qnJHarwGmyIBz8akjIXUW/L/jXxEpUam26NNgt+Meftc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI5T3m1q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI5T3m1q"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16c399641so12131615e9.2
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791740039; x=1792344839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6khg2ySPx5GYZEE9oh5YW3CL1Pu4Rm7qSXlUY8AbDv0=;
        b=ZI5T3m1qoDfaG96sqvPTC3xACK+7geeRMCnIdsZFOHhG1qERvNL33qWjdu/rcLQd5d
         tm5dbCKN4HRr1TZhIwlBxvPdfHTm43kPdBddBrnFg2lIyjOp6MfnbGcp6hRJ36QIxEee
         YhoRZCAG7JnSxU7EUA9sstUiC6jat85G3R4S1SMDEe5ZhbertvVBobzMl3tpG2gJsnB7
         Wn2rxEyeDP3C33IKCPNv+4VNoet+AfoeQyUqRLsNvZEnR7/2RBLt7cu3PfCnwzsZFynD
         fh/Ujpg6vOWFOGhE3MTZhfMb07PMcld31Bq3rFzjgYgOvBF9tU03Ivt8+IJrER89oRge
         6JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791740039; x=1792344839;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6khg2ySPx5GYZEE9oh5YW3CL1Pu4Rm7qSXlUY8AbDv0=;
        b=yUOcIF4M9aHWEvETGe841s5/6m+SyCGodK/jSsZe/3BF7WoAHuO5TWD5vUb0tDiYt5
         jK5gOlCAb8UuiHyNQeYCHD8qefvF4gySdOy5U6RenJZpOzaU//JA4bVpdJKXzLx2zTY8
         0JwtASDbwHWb6uX2bpp+Lv5rA8/SeBHxF+U+BSt1XQu+jR3ABDZrhkyabxWWlnQ/m8//
         CezBDQcTEk71zsrvM8Or8lc3sfjBnYBUHLFjSWccxk4atDwfceNoC34Oa7/TUng9TZjA
         nid/+89CVZIniOTVral+LnmjvsJTY65Lg+y2nTM8qFU4KHkt+JkmcMyIs5Q4YdDnHjf1
         N4hA==
X-Forwarded-Encrypted: i=1; AKwUvBxt7bFIsTmSFWoqvowG3m9ew9z8IAioGbtLIup+GOFKWIXNTpUiOMXG2Ewz7//mQJvIqpDe5MB4bdc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5F826fKNzZzKzbwwlaFoohdOjp5b6L3jT/jm7YR6VfOfTVJ+x
	Nqgc/qRTwn//X2EX7CR7unTOIfIosZHzy67s1GwDx1Rn7t2D3Pr2JJc5
X-Gm-Gg: AYBFou1+2n11vnJ51Dt8bkA8jZ2CNz6J6gMrxOntf7yv+pj1pAcIJvKSPndOIOHhOGE
	fIpsuRoDSXfFsEghWB9M/w8f913zlbbkGSR+cg68vHj21KHFmOMy1muPiTgavWyMUXyLfhNa1/L
	+Aozfgvkh/oq+lCYrwZhuUOlGQQxp99c2XmblfUoej+ZFp75kMJqzOQWZLtbKqA2OG/JTWNM4u8
	x3mCsQH4Hucsf6n1ICMAytSliyZ6qFQbTxaG/LJRIAEo9FW0Dku+/zpj/c38lDz46nuHycZnNPV
	7R8QFaonuhYobNLgZHmDa5Qi3CuhvLh6DdAid3QeD9LJ62PRS5ZdLqEWhQBWZmpwnEMV2w2SxYL
	pm6KCRZ/KnUSANxzJ4ZieyoGaKEGPfCWPlknXJlvNOu3F72LZZdtWp560OlB5vbSS95pyw5zTZJ
	HaHxicL1mGRSMNh3KGeX+RSxoZhpE6ZriJqhZMwkyIMdDhcXt1KOAxEaB9EemPl3gnbNJP4n547
	OicIS2RE83StxGkA+9cLVg1m5eco6lX06trgwlAPvJkrP9fgMEqBxY2/3lyOT15wQyZva+yblzR
	ACYFFHqUc9710q9Pq/Sb5iXx4v5bMjowux6aoTNmIsf956toTOjOFffQAmDFkHwwCaeRD8ZU/FV
	5qOO5FD6wHNkYn650BJd5vZFA7bqdZquBvBPYAv6yTw==
X-Received: by 2002:a05:600c:19cf:b0:4a1:7b56:1151 with SMTP id 5b1f17b1804b1-4a18e48f00dmr137096565e9.18.1791740039242;
        Sun, 11 Oct 2026 10:33:59 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ca51465sm173866565e9.4.2026.10.11.10.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 10:33:58 -0700 (PDT)
Date: Sun, 11 Oct 2026 19:33:57 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix kernel-doc warnings
Message-ID: <20261011193357.51c393e4@systembl0wer>
In-Reply-To: <20261011045754.358335-1-kapoorarnav43@gmail.com>
References: <20261011045754.358335-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Oct 2026 10:27:49 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> scripts/kernel-doc -Wall reports several warnings for the inv_mpu6050
> driver:
> 
> - inv_mpu_magn_get_scale() only describes @st, not @chan, @val and @val2.
> - Eight functions use "Returns ..." in the body instead of a "Return:"
>   section, and inv_mpu6050_set_enable() and
>   inv_mpu_data_rdy_trigger_set_state() do not describe their return
>   value at all, e.g.:
> 
>     Warning: .../inv_mpu_aux.c:87 No description found for return value
>     of 'inv_mpu_aux_init'
> 
> - int_pin_cfg in struct inv_mpu6050_reg_map is documented with a ';'
>   instead of a ':' after the name, so kernel-doc does not see it, and
>   user_ctrl in struct inv_mpu6050_chip_config and startup_time in
>   struct inv_mpu6050_hw are not documented.
> 
> Describe the missing parameters, members and return values, and convert
> the return value descriptions to "Return:" sections. Where the return
> value was described before the long description, move it after it, so
> the description is not parsed as part of the return value section.
> 
> With this change, scripts/kernel-doc -Wall reports no warnings for
> drivers/iio/imu/inv_mpu6050/. Comment-only change.
> 
> Assisted-by: LLM
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
