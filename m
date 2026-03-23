Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EDB3AA4E4;
	Mon, 23 Mar 2026 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272255; cv=none; b=nZDcSSR5c8UHnuFztnhVrgUEQHAbB6z7BXSdu9CEi1hoHXYqYJpkOQYx0g9GVOmpI8GN71V0KoIYHxVtq7T2MfdB/gxMk5E/L6sRmoqitKmPcKKxk2802Zdv0KIDob48uOI1tQfF2PvT1iIW4WmSqCLjXRTU3716yc8mRV7ZFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272255; c=relaxed/simple;
	bh=mqs5zAZq0cjIjQqg6msmfW+S/T7XdFMiumdtkA29a98=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=oKDh5ckeO1ip+7BLmcmKtM+NI1ydSRJKqt4ucoXsn2lwN/P72QFb5n/TNyaZByell8k/+pPQlR3d5LgT+GIV8DyKoEfH5HMKQ3htvzeSasDGpPEJNrKu5XjRFQsylfmx1tFtf1Xagfz7GI1rUsYJS0BfdJAxsMcvuH5sEaOXtts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0PcgubM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0PcgubM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36925C4CEF7;
	Mon, 23 Mar 2026 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774272255;
	bh=mqs5zAZq0cjIjQqg6msmfW+S/T7XdFMiumdtkA29a98=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=g0PcgubM7/2phLSEIfZRJcQYY5dMdgoRXiFXuASh4e5zc4071rU9I/1RAMcvy9KME
	 KRFPwmvkem7JJe8Q6mxesGSAEB1G7wBLq4IEfc3IUTtUFJOjmKUSWvflhAvMHJz7+f
	 wAgUxsJBrFSHRxstToFKClm43R0I6xdM/0ILGkOA5voZjaVAadO8egJQQoeQZCUd+5
	 bI5RZQ++eN0qMNdOHVICj69lNL6LsHMC6hYn/x8/KypmKEnUpb3hLfCX8U5bqoSKmC
	 2nwSGw/CNKBe+vVdzPoYfT4bFkZJHZmQM2z8bVqbqcXx7sLHPh40tK1LmR4IVgne2Z
	 9LCp15QDNQDdw==
Date: Mon, 23 Mar 2026 08:24:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Michal Simek <michal.simek@amd.com>, Nuno Sa <nuno.sa@analog.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 saikrishna12468@gmail.com, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 git@amd.com, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 devicetree@vger.kernel.org
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
In-Reply-To: <20260323074505.3853353-5-sai.krishna.potthuri@amd.com>
References: <20260323074505.3853353-1-sai.krishna.potthuri@amd.com>
 <20260323074505.3853353-5-sai.krishna.potthuri@amd.com>
Message-Id: <177427225202.450573.11125989986102537734.robh@kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: adc: xlnx,axi-xadc: convert
 to DT schema


On Mon, 23 Mar 2026 13:15:05 +0530, Sai Krishna Potthuri wrote:
> Convert the xilinx-xadc.txt to DT schema and remove the old text binding.
> Update xilinx-xadc binding path to YAML format in MAINTAINERS file.
> 
> The 'xlnx,channels' property is a container node(type: object) with
> a vendor prefix, which triggers the below warning:
>   "properties:xlnx,channels:type: 'boolean' was expected"
> 
> This cannot be changed because the original text binding specified
> 'xlnx,channels' since 2014, driver explicitly looks up "xlnx,channels"
> using device_get_named_child_node() and removing the vendor prefix
> would break backward compatibility with existing device trees.
> Also, keep all vendor-prefixed properties from the original binding to
> maintain backward compatibility with existing devicetrees and driver code.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>  .../bindings/iio/adc/xilinx-xadc.txt          | 141 ----------------
>  .../bindings/iio/adc/xlnx,axi-xadc.yaml       | 154 ++++++++++++++++++
>  2 files changed, 154 insertions(+), 141 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,axi-xadc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/xlnx,axi-xadc.yaml: properties:xlnx,channels:type: 'boolean' was expected
	hint: A vendor boolean property can use "type: boolean"
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260323074505.3853353-5-sai.krishna.potthuri@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

