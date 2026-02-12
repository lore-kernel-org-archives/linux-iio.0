Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB025B1DA;
	Thu, 12 Feb 2026 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917516; cv=none; b=mOMlRWVtPKOoH0PezlAQZwBa/NbwxK9ICzSJegZhgJV7ASnnCiZjUMdWGRMmrH+TUilp6l+Z2Sohz3m0Nt8WPx+/qNcJ3ZeOEDAGCqYT/Ep3Dqm4R9tjnQnXg89jmm9q5raBdyKz/ueaQb5olOptbg1aAdmBWjWJi5QOvmOryOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917516; c=relaxed/simple;
	bh=TrYRVRvH7Nj0gYOh2vxI9kZs3a5bJivRNMzIp57hql0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mKKbM6FMvOvQa2kcL7gbW8TgWmSsASSPQ38nhbef0cPVVbylamFheiqzJ+q82mKFdZ9B5HHCciNjDZ8lL633Wrh9f+regIF3S3j3fe360zDIqnZBPRiYKTDvu9kIqk2SRRpdgC0YVaNcUbetXp5RwRjzo1l/sQCdV5sQ46e5wvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf6KdEVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf6KdEVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A4AC4CEF7;
	Thu, 12 Feb 2026 17:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770917516;
	bh=TrYRVRvH7Nj0gYOh2vxI9kZs3a5bJivRNMzIp57hql0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Hf6KdEVWiXJJX8PRf3NCMFpdvhiQ3bP3Y5No9R1b1JNkBJHvdL3xd+Hbavr+cY6ag
	 zuBIi2ynkFFuQC8XqSigaErlJvHWZ2peVXnbKnbcYLZfl7Ub4o0ZO+bOd2gb2pvBZ9
	 atafwJl9TYNueQk1ceyAufQBchCWJeKrvvYNSA+FPTm2cBwBJLvzIXn0314sVypPUv
	 pNQHWBXxv5XpYCJZVr8cr5iPl7Regrof6HBC2R6/Et2yx0Rg8xxB/fi003py0gjLAM
	 RjB0lTfDGIqUfNNrC3rd9U3nd1lPih9j0gBuRJMLmqH47PFUs7XM6Wpx6Vcj5oR6hk
	 5itxzU9nslxlQ==
Date: Thu, 12 Feb 2026 11:31:55 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org
To: Ariana Lazar <ariana.lazar@microchip.com>
In-Reply-To: <20260212-mcp48feb02-v1-1-ce5843db65db@microchip.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
 <20260212-mcp48feb02-v1-1-ce5843db65db@microchip.com>
Message-Id: <177091751536.449067.3108703544618306687.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02


On Thu, 12 Feb 2026 14:48:34 +0200, Ariana Lazar wrote:
> This is the device tree schema for iio driver for Microchip
> MCP48FxBy1/2/4/8 series of buffered voltage output Digital-to-Analog
> Converters with nonvolatile or volatile memory and an SPI Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../bindings/iio/dac/microchip,mcp48feb02.yaml     | 299 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 305 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/dac/microchip,mcp48feb02.yaml:275:5: [warning] wrong indentation: expected 2 but found 4 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260212-mcp48feb02-v1-1-ce5843db65db@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

