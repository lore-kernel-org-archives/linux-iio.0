Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821538;
	b=0mEn7qG2Ev6kU31HlucO0ADePHNDk7iMNsX3G/wm+kI0iG7p7nDLvnIsMbnT3OBiFex6
	 KFq9JNf3E93BIQmgmd4cE3l8TFVnOffgVfZPv3CA6qxUUKPmR9D9REcroRB2+WVsAvV+9
	 LwU1MOhIA1vJHke5Xc8lBq4IWTc8GmSJD+RTCEKNCZ2r4GFZYxYj+YOQW9jTCVjvoGC6z
	 6RU1d0Z1sEgDpxs/+HFb8QmzKgmjWbBA5PHxyNQkMmsUTTS0yOxuzJKEfNeQu5fxZTBGo
	 c9WIa4ILRlwYVYbaAITMpvHA9fHiDDWTrrXx1M5bfxAphcyxO9pujTK5rbRiaYwbicg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821538;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=U1td2Wbfq2GkWwBEkRCNUg6KHVwyqmaWhIkCCTO62zY=;
	b=NQMReR9EGJVR9eTKhp3G1qPXqJtkrP7DASwc8ADKDPyXUUh7tE492VRdfoP+CFMA/SJO
	 9p4bqxTfeKuCrkndcungxr9saGs6hkBNVxp9FLSwUfBkmlw/6j3U3/EFtEcDavY2/eMUH
	 Nax00iLxIzQe56Ytt/xqV2/ydisa5ZyIyeFZ+Yj2e2uLTubFBkAgr8R0PewZpjoE0SUIM
	 rI51+dfyVWnaSMcDXmi31sobkGzJK6l8nLdYAMjn9D2hVTsmVqb1IDef13TsQ86FNAI96
	 L8IGeiUlK7pxIo4x/VXkrQepjioknQ2RPmbFYOoS0/rDzQDQhY2CV91cie+/GrMwJCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nya+8OsQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3057E60C54E0;
	Wed,  4 Nov 2026 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nya+8OsQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815BB1F000C1;
	Wed,  4 Nov 2026 19:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821537;
	bh=U1td2Wbfq2GkWwBEkRCNUg6KHVwyqmaWhIkCCTO62zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nya+8OsQ78Q5LVZ7zvMB4DxIW32AMox01qJMR2XAhbZ5frMVLmT2MKVxh7qMrwIKA
	 T30WWg1W98H96Ol5yhpz5gkQZsFQXYFp6PfsPxMDd/lUtTz0Z3JEWcly7uNc2kPWKG
	 QZbiU6ZaqBffl+D6gvPC8ByVaUdIZ1NCXXrr+eqZ+USJ7gxvoeCtd6xK7BkbYG6KM3
	 VfJPsXw6DjId508qbuOFwGfnZGozG/wQXsqsKB5ku4kmAUiF8uNlbv1zT4vNTj3Qc6
	 p2W9klgSf8CWCBnEiKVEVWUE8k/ovmtEc2zfvnlO1VvEjMqqGOwqUswY8MV74ekv/R
	 7p5Ci3LZmZjfA==
Date: Wed, 4 Nov 2026 13:45:36 -0600
From: Rob Herring <robh@kernel.org>
To: Christoph Rudorff <chris@rudorff.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: light: gp2ap002: add leda power
 supply
Message-ID: <20261104194536.GA3568714-robh@kernel.org>
References: <20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com>
 <20261104-iio-light-gp2ap002-v4-1-fa1cbaad2ce5@rudorff.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-iio-light-gp2ap002-v4-1-fa1cbaad2ce5@rudorff.com>

On Wed, Nov 04, 2026 at 02:02:27PM +0100, Christoph Rudorff wrote:
> According to datasheet page 8 "Recommended external circuit",
> it has tree pins that need power: vio, vdd and leda ("vled" !)
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>

Missing Krzysztof's ack...
