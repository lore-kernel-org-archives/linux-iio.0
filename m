Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00E414A2A
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572818; cv=none; b=Z25On4Runry4vz3cphjYSzLCghI8EwxctBiCMkhK3wR/rSY5JYpSOA1Gsre4ZV9hd7U0ZKp3qFSfUNncykmkpjbSV1yJFU6U+vHyFwqGQCYDLoMwjTVApK+GJCGCAuzYFGTMeWNzoGcGjebhwqakpxQYOrl+PH/WD9mLJxiDBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572818; c=relaxed/simple;
	bh=wehBoPAFnMWIlOR/1hMFMoLL9ogZezGXsy8/qgXQ8FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okN/pYcbltRvRjCtrqsJuDZAlSHQe/x2jJXo/jLNXkKTqEy3xGPp60ckM9qnzGLb9O/tHn/RtoZtcKXcCHGACUqbMZXix6q1jfyo8j45+CMsyddW5EX6v52hOF9FeV0JvAaQHPRB7OV/I9iW4fS1hZqLA3w+MCRW54UMvPWrdS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRHtk+fU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRHtk+fU"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cab973140bso43078795ad.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 05:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787572817; x=1788177617; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLH2hqwn3vkTX39PfHLgy/sCe/Pt/ywfZsI6UoXbmOk=;
        b=sRHtk+fUkR2yUImSOZ9AHUt7wSTYgmNpBF7ps3t95TV8nY8paAZhBP+/AQ7TBZsCYJ
         1eRZUn7kI649U0vztPyPu13xGtiFj3VdQ0IDqI2AxXCjIZ8zXC93YpLB4mkZT4aRJf94
         oqm2AqcSO+vU2Xbq14KLUrQgserqI+okKakiXi2ddqICMpkWh/MDubkOZo06umXFh/rc
         QOhS0IVvgU2ruSRayAf3PwIji6I3EOJsVYvivVo6yu5QPGpAngGmrN5Z+05vYxIs3Xi8
         z7DMurvLR0we8qi3qHN7uqFnL2kG8BQg5x7gtnxRuCDxzVTLGW8idvlxRnqMZzGx7+t2
         lyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787572817; x=1788177617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WLH2hqwn3vkTX39PfHLgy/sCe/Pt/ywfZsI6UoXbmOk=;
        b=LUKgvc00pJcya7XSruOrVWX0cIscEdQPrIebMIpMPidvgG9d14skM52bKUNjU9zUMz
         t3g717TaneiueJcg1fSUk/XKzHh+L0Aq0h0tS5lervxJvwiJxpnDyaWQBjlSgTa9QR8f
         5hlzAhIg2Va+2JkLho8CP5ymJYGryhzti1DWABEU+imEoMa4uTzxK0y9Gk1Rm2XZBC8n
         /S4UOJNluEAHv5q26Ropzio/y/DELc4ubY0BSQcHozAgxaPwcxu+fDx71n6V4LQxVudv
         3jx6RkNfReN2y9Gbp4DZvYE+eKTTggHEaeASa6/brzitlMXpL3OwCEIvgbHYSoy6DSku
         J/+g==
X-Forwarded-Encrypted: i=1; AHgh+RrNIIrY70pV+5INdjCikRAWekcD0bN111dnyBXugglLMrfM3uDbDSEcYwHs4I4Ju6dDeCNwyguRRyk=@vger.kernel.org
X-Gm-Message-State: AFuF++l+x8YQMBgePq/TnZiVYc7e8jc4OPeBKfzzjte9J7klJbElbdL3
	J26pumGrU+AxIW+qcij/h/pX/LkpOpqjRE5hKEQucvldIK7caY9hFSyy
X-Gm-Gg: AR+sD11AxeyupG+EytG1QaG+TLjgSVjhSUnB+7wHjCuPybSxIF1iShwwLJS8LNOgAp0
	Ibqrk2uBdvxwWD7bZkGRZVmbULVO9qYP9e8vGe93MEd8twpkPIvTAEeL4/+YifL1w4+xJkzHNFy
	4woP1GNZhEfEs2prtL2Y2zCU3rLBpOktieRSCSxU2q0qYjvr6bMxeEjYGdDn6YrAdC9VDHMRRg5
	7jQokfplgBIx9+AP79UodjmYQtet1hX9bVxEH1yzfsu9jjvuN5TF0FsKMkquaYwsUR+DcKGHVv9
	TqcXW7YCXnkjZFJ30XRhmhNB3ZHuyeT++N819t9zYBhLfLHc77Dk7/L0LzEegA5vhYLqp9ujExD
	GoT1E0dR8OewkGuKP0E7oBeTzYsJaMkhBpFfI+iriEDbCuFbfogsMWniTs7sxlD41qPbxEoIqrx
	xR8teNXuOVwhxGGGjU16nWfQ8sd+t92Bsi1FE7zlqN9IAc3EN2wcao2vPoaQ+hRbxkZ2aC
X-Received: by 2002:a17:902:d48f:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2d670b85236mr264502195ad.4.1787572815669;
        Mon, 24 Aug 2026 05:00:15 -0700 (PDT)
Received: from localhost ([2804:30c:97d:e800:9454:1179:18df:ab33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3280af94751sm17053707eec.26.2026.08.24.05.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:00:14 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:00:56 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux@analog.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: update unreachable maintainer
 entries
Message-ID: <aowyePkyjRVpqhV-@debian-BULLSEYE-live-builder-AMD64>
References: <20260821180753.4633-1-antoniu.miclaus@analog.com>
 <20260821180753.4633-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821180753.4633-2-antoniu.miclaus@analog.com>

On 08/21, Antoniu Miclaus wrote:
> Cosmin's Analog Devices address is no longer valid, leaving the ADXL367,
> AD4130, AD74115 and AD74413R bindings without a reachable maintainer.
> Take over maintainership of those bindings and add myself to the
> corresponding MAINTAINERS entries alongside Marcelo.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> ---
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Thanks
