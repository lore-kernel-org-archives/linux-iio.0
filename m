Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D483B7B97;
	Thu, 26 Mar 2026 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513169; cv=none; b=hJsx3dpVf24/E6CKudVRU0i21Y1bJpNmbAVePIzo3fSHQEIt9xzMeN8jQNVEzSwWsceDPZEs1wiDTj7eP/0GFeqRf3cHNUW//q5lrjQJrdl2WRUQmDAkj224u7Gdqq1MskEgcEUendLWvpBE1AqP60C8whFVXk6NtSEEaJ+s4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513169; c=relaxed/simple;
	bh=j7dEXpshropQggUha1Yhid1uTd6fGFNzT/dBvVT5ZnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksmf+saM4XaLlX5ArB9FgGmAj01hp3tTh7q0Vj+L0Np31KSUOadR32nAxIuQH/6lugg/wD/SsnTA4d05rfhtJs84HLq3eqL35xJKNo+RDAB3DXGBCWaFdBunLEhaH4Ymffozi6nQ7ZGUg5Euot7NPoDTS7WHOGN9MGCnyDgw1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWVQGp3O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWVQGp3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37A3C116C6;
	Thu, 26 Mar 2026 08:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774513168;
	bh=j7dEXpshropQggUha1Yhid1uTd6fGFNzT/dBvVT5ZnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWVQGp3OAxEx2usPa1FpmekCldyhV7PnB8HuiIJp20xt7ttCcihLz8Eo+seAkSeav
	 zgMWcwQoW61jIebj2W9FxY/C7Waxt7peP7iL8HrH991e3uRuLDsdbBmwRo0qxUu1fp
	 eLqimMZUaHD3OLKx3+falPd3RdsrbGHQUXbZluRIEvDbQWO0Ai7sXrThbX0r8AVou4
	 KMzqd85XQC+E0tKTkDbhPD7mLsyOlwxuZ3A71SAFB/RpUaqFu8QOc8KRFrkS/XWj4r
	 uoD28h85EqZkYP/11PJqjUyrJ2wFjwZliDGya31jSve24hcO/a6RenYbWXL2j3EgHe
	 bvVfVAreFfauA==
Date: Thu, 26 Mar 2026 09:19:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Xie <nick@khadas.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, 
	martin.blumenstingl@googlemail.com, jbrunet@baylibre.com, jic23@kernel.org, dlechner@baylibre.com, 
	andy@kernel.org, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: amlogic,meson-saradc: add
 S4 compatible
Message-ID: <20260326-secret-quartz-booby-3d3e61@quoll>
References: <20260325070618.81955-1-nick@khadas.com>
 <20260325070618.81955-2-nick@khadas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325070618.81955-2-nick@khadas.com>

On Wed, Mar 25, 2026 at 03:06:15PM +0800, Nick Xie wrote:
> Add the compatible string for the SARADC (Successive Approximation
> Register ADC) IP block found in the Amlogic Meson S4 SoC.
> 
> There are no known differences between the SARADC on S4 and the one
> on G12A. Therefore, it uses "amlogic,meson-g12a-saradc" as a proper
> specific fallback.
> 
> Also add a comment indicating that "amlogic,meson-saradc" must not be
> used for new devices. It's a made up compatible string that does not
> correspond to a specific hardware generation and is not used to match
> any driver. For old devices we keep it as it's part of the ABI.
> 
> Signed-off-by: Nick Xie <nick@khadas.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

