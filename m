Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51B3A7F74;
	Tue, 24 Feb 2026 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954151; cv=none; b=vEUhdvjjp9sP7Qlss8AGsPeg9tMGRtE6ffi5cNT07PYD9KHUl/Xiy03Wak8Vpn+LzBx0e18TeI3Wlt1+Gd7iLmz2c+ZodEMDw9VhZ6oUDo/Ce7QOf8PgUV1yHYQwI1GaYuy9fLsQjZKMer0GQ8dMM8/OVbMgSeRl45e2XqGrLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954151; c=relaxed/simple;
	bh=pSGqZebvO3+aycQMfeI64m0G/5UvaBKl7jRANx8yJ/I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=AhhCp+1McfXwO4URygUm/c7BgAhJAGPY+NPOZktbe4HWRT9MC/K9OMhVtwtrjYNptrVUo3igHy23reaxY66NB0SObcTPGz4sGVVl3U8XWNQTCY6tylNyVqpl53pzTQOOuMLTXgrDzIhnUXGnyTQEcLtO99EFZ56tqftciabsww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZM9d1J8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZM9d1J8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BE9C116D0;
	Tue, 24 Feb 2026 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771954150;
	bh=pSGqZebvO3+aycQMfeI64m0G/5UvaBKl7jRANx8yJ/I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=jZM9d1J8DoyrvyLJ0oc1B+mv3rXFoGSMx0ZL3qxSurA0IMb1iCGNbasMU7Ihcpbf7
	 Gh0NfjeXVW5Jh0doKiPA2bpKQV3MlKSYZ+Ak3ta/zu7Y79pw/dUzkLSzem6ZLidtB7
	 yOtCLmuDeMaPv1/ahTuGAyGo/1vM6dOC3Pq2cbDZxqal5eljxbwQ7USfRrA35Geo/t
	 qql40er/LOfMqZv3KhZa556pFWxmtAW6UxzGfbfeGWcOSQDqs+RAzeCDCea1D4C1IA
	 gZ2CYXex1uiADBx42P/ZwoIZYNXRdTcMh+6UT9kGQy+RuXDbdqfBGhmAdVUr8Eoj2Z
	 MMM5rAjOUks8A==
Date: Tue, 24 Feb 2026 11:29:09 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-rockchip@lists.infradead.org, krzk+dt@kernel.org, 
 linux-iio@vger.kernel.org, jic23@kernel.org, 
 Chris Morgan <macromorgan@hotmail.com>, devicetree@vger.kernel.org, 
 dlechner@baylibre.com, conor+dt@kernel.org, nuno.sa@analog.com, 
 jean-baptiste.maneyrol@tdk.com, heiko@sntech.de, andy@kernel.org
To: Chris Morgan <macroalpha82@gmail.com>
In-Reply-To: <20260224163109.370930-2-macroalpha82@gmail.com>
References: <20260224163109.370930-1-macroalpha82@gmail.com>
 <20260224163109.370930-2-macroalpha82@gmail.com>
Message-Id: <177195414948.3145595.4265112692565898282.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: imu: icm42607: Add devicetree
 binding


On Tue, 24 Feb 2026 10:31:03 -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add devicetree binding for the Invensense ICM42607 and Invensense
> ICM42607P inertial measurement unit. This unit is a combined
> accelerometer, gyroscope, and thermometer available via I2C or SPI.
> 
> This device is functionally very similar to the icm42600 series with a
> very different register layout.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../bindings/iio/imu/invensense,icm42607.yaml | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260224163109.370930-2-macroalpha82@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

