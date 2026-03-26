Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F938C2DD;
	Thu, 26 Mar 2026 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774510742; cv=none; b=cC5AnmMP+SDtu4bCUpm74pf6AAgR5jGlYWmzKt4py93DyiNWZE0u+XllCVvhsFCmQwtL7rL7dgGAlSApsuIp7e5PIhYdDK0FofJq22wIO8hM7nhcYJfJ1Yydft7VsMRH4K2wKzHP19UJkPj7hJEdbbITJIxd64pS6tNGbweIgIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774510742; c=relaxed/simple;
	bh=jOofACOGH2cnvv5dOGa183YuJXFzB6KDd3rkXHZK3C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5JzkeOHM+Cmh1/XfCvTQ5teOm9AdGBghEwbfOG/QbHsUZWGClE6Hj4PncsPh2oS/saU0h6amVqHo/44pgwdrfJgsZ6JehB/ERb8FXGEuB7HKq3yhD5uwZkLzua4OFCFAWZwb31IJq4Ogi+Amk/gemYQo62QQ7/2VN2FeFVz2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG9qc6lU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG9qc6lU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065CFC116C6;
	Thu, 26 Mar 2026 07:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774510741;
	bh=jOofACOGH2cnvv5dOGa183YuJXFzB6KDd3rkXHZK3C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pG9qc6lUdz5z6XOXNCyvr1YJPTBSRylVuQ1njcKXqbYQbi8GC5zmlVG1svgZ6nqjY
	 xUTyYf3oLYSCvPr/m74tYEgLL2RTFdRUD6+OjW+wS3F2siqhZHpY6Brm/ozqg3GiNc
	 gttZFsf16lE88ts36ybm0OCB833sEXU2dlsC3z2Sqn+xFLYpRgFOEPAejN0cDpMl01
	 riohj8dIiYfTAowT9NFI+EycEf/fMoXhHTcn/48Aua7Qx9luwlsoMmcp+JXI3oQ70V
	 E6F8Ja7Y5Jgjuy8m/045DAgznB2WRk/bhu/2bCvlprrjv/shbWDP/yuO8L0Sn7DHAN
	 RqfryXfQ0T+UA==
Date: Thu, 26 Mar 2026 08:38:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF
 sensor
Message-ID: <20260326-noisy-successful-petrel-ba85ec@quoll>
References: <20260325202005.29822-1-email@sirat.me>
 <20260325202005.29822-2-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325202005.29822-2-email@sirat.me>

On Thu, Mar 26, 2026 at 02:19:41AM +0600, Siratul Islam wrote:
>    vdd-supply: true
>  
> @@ -28,6 +33,18 @@ required:
>    - compatible
>    - reg
>  
> +# vdd-supply is not made globally required to maintain backwards compatibility
> +# with existing st,vl53l0x devicetrees that do not specify it.

Commit should rather explain that, not code.

Anyway, regardless:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

