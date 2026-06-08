Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396073D092F;
	Mon,  8 Jun 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939382; cv=none; b=sUQKBc8+sIBSAQ2CX2O/L8Ky0MZmCZpLAWbMXbc2scxoFKfxKwNFp9oC1LOq6rpO/HVMw3Yhs8uKm5JovLHjs7jotNW/97Hjg92BU8fsNo6s9zQk1ObpTkcpHWbiE1OJ5+xN594cxp3KxwhC5+RgG7EpkJAk62EfrzHlm+fYtZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939382; c=relaxed/simple;
	bh=r8PLd85HwRlTzpotvIRlIjfgapnRH2jIMjEIwy0p9fc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Cl9FSQ5S600p0eJEL/APlZQ1lfSZazvkXd7KuDTBWHt3B7EPzX44U6AarbY5XQouJ6qlduBJNAHojoYGDqiX7H3gKIcV2j3A/tnCHQAWGiv8vV3WjAlfG5V+e8Y/JCOIHdvdN3+SWXsFyEK7ASSwf2i7w3R4uEf96bsXDjJgc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0syz3yB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0syz3yB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984721F00893;
	Mon,  8 Jun 2026 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780939380;
	bh=dl0TTg40vxY5UuFHrTwr6GQCkMLyDCNTJHl0ADHTdio=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=h0syz3yBljdTEvHlRSXMXEpJOwJUN6PlpR1PyRT4vP/fZg8cAuhNqa0Qz+ZwHdkm0
	 PHL5SqrrBHvNNVZKO4qU3f52TJArveUfn+WrxInYyGQsGzZ+oS5YFGR/Jn7OXUu3KT
	 PmvS7pN+sCp+oFj1dWOg694wM+Zjt6szbYX8pKJUNllNP45gZgnXG/+xv73pfdw/zq
	 Jny8idftVnx2aEU6tZ/mxDaoswT+DxSrJYcdTAkQyb5e3/1Lfbsq81uNxRVkI/qjJl
	 5AU6KmAf7lASSkfv6Tlt0zjePir5oq/v5DILoQkBxWmk8nGRa3kOSw2gCve7wGtI4M
	 0PoI1XExW0qCA==
Date: Mon, 08 Jun 2026 12:22:59 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Wil Stark <wil_stark@keysight.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Andy Shevchenko <andy@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 devicetree@vger.kernel.org
To: Romain Gantois <romain.gantois@bootlin.com>
In-Reply-To: <20260608-tmp119-v2-1-30c3537d5097@bootlin.com>
References: <20260608-tmp119-v2-0-30c3537d5097@bootlin.com>
 <20260608-tmp119-v2-1-30c3537d5097@bootlin.com>
Message-Id: <178093937961.3012439.17414115705796427951.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: ti,tmp117: add binding for
 the TMP119


On Mon, 08 Jun 2026 18:00:24 +0200, Romain Gantois wrote:
> The TMP119 has the same register layout as the TMP117, and a better local
> sensor accuracy. Add a compatible for it.
> 
> Use ti,tmp117 as a fallback compatible for ti,tmp119.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml   | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml:23:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml:26:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml:27:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260608-tmp119-v2-1-30c3537d5097@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

