Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884CC31195B;
	Mon, 21 Sep 2026 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955468; cv=none; b=ZIvBc+VwxLeELPIckbzJ4QrULDUcbS4/dyNkDPpH8nrj9jlsQJfhiclThyHdzOBjclOw7cw4wzGVAV0LKF0kfIqzyzTXzqL52nnJmlcmYlzwAJwjpsMG7/iP1DzIzt48VZRpXDHXvTmP+FusUj0/27pw0kBcewUYYL/73Qe2DVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955468; c=relaxed/simple;
	bh=SZIF9iDnMvUeXhVezcXKljQCVwSlsFloxxL8Kv+fMw4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cxLbMVYjcDKA5VBBlG983LtA54SiPEbHJdWcBkKcd1aZVzRIbnEvxfQpnDVjx5vFEduuUdwEovl7cM74gZkomshEgd9QxO+dutUcoOatTmW8Tnl3TChjzCe8WgXEhhAYG5wU3xtX6LWSC5T/GHOZmp1X2h1kZRZxRVQ6mREliqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+WpwGdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+WpwGdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20A41F0089D;
	Mon, 21 Sep 2026 01:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789955466;
	bh=Sb9foMsHfH9st8FVUhgFtiG1JqBh52X2lbf2oFqA3tA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=E+WpwGdEd3llJvsmlkXlM7gDUrtDM2DfM5VfHhGOh/ffM0vZHvN90uoIMn0BCa+0x
	 iLavzby+jbz/nPk1ZcAVe6nW1s/pPKvJ/BzT11my6UYtgL3M6+w4aImxrHEKpt0YRd
	 sdF4bEnk34MQpCN3xNEOsZZYN05Cjwwu2p349JA9+dumBGWeDbFIykFC11qtIJH4+J
	 g9iQafXM9hf7kuvUpvdnsX3sODZ2704Hga0r5Xq7iIB25fNURqMQiSBRvbJ9hiZwxu
	 9b/8Hy989Cxd161ICYuxvsasTplqkTStOPHM53LIika0V6lK++XeQEsrZsayKq8VVU
	 GFQ09zc9/ZxeA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 13/15] dt-bindings: iio: adc: adi,ad4134: Add high
 data throughput example
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org, 
 nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org, 
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
 marcelo.schmitt1@gmail.com
In-Reply-To: <958894021cf7bd3012567d1dfabd7f2008fe8d31.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
 <958894021cf7bd3012567d1dfabd7f2008fe8d31.1789494473.git.marcelo.schmitt@analog.com>
Date: Mon, 21 Sep 2026 02:50:45 +0100
Message-Id: <178995544508.955708.9865443380631226751.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=343;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=SZIF9iDnMvUeXhVezcXKljQCVwSlsFloxxL8Kv+fMw4=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsI2E+RshzUXK9SVl3vn5DjSdtrjazaLMRaqRn
 BJYi6pSouiJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarCNhBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiN9uD/4wJv4HiiNzBc9YycavW6VXYfR0uXyU3ZgujRtviDn2uwG
 Jj/iS+ujWxeRcOhCKLdbujaRpLVeq9b0M68KNgx9jqUx1t5TWlma41/pJB91j40j7xGltEQ4Wvz
 xcbnA4nbNLBAbQFgN4uBpR3HFBX8im+XPD2c/1+lHmovMiQjtZ95R7Z6woPK0ErOmJpDwagHI2J
 PqRoHRM805F4kVfMClOXCBkAJm+wdbK/fOg8JX+7rUuvrYQv4xYqeZjzjh3Fi6derlE81lnop/Y
 ZnSiEWX9gkOO2a6wgQ6ir/qHtI2CP0u3aQkKtmkygbxvnyfEcJPG9M8BJGD2JGIPL5SbWIByi4s
 NdGBpzgS2t5fJ4pIGUxBLo+1aqaukZGdHs0GTV0LEUftVzw7RkytexRzgFeZGMOO+BTd20M9Tf1
 qnFN/pLpFLTPtbMxBhk/hpbdo6oyJIQumugyWHo64vFsTFCt60fk1sx1fQgto1p/g5B3lOy5VrD
 7247Edp6SbYlCnGPynR8n1RsjzSasd6LQW0PDwTvrUk/XgBJljqsKANulZqtAOLl3aEYsWeQmhr
 aqwpC9llH4WPoHvxF0ejJQFIqPxSRBFETjsZxUkL092h+RN/sZlZQzOjagPxrt1hraxf2mKZlM/
 HQQq75zDhmM5ZxVHXN/J0rDUHmyEWi1lSEWC9Yg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add device tree example for AD4134 operation in 4-wire SPI mode with 4
> lines to transfer data samples to the host controller.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Why not do this earlier in the patch series - before introducing
4 wire support?

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
