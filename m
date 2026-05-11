Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5586B3BED1F
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491757; cv=none; b=fCav+Q34oUGP2dxq7L0GtP5AKaqsnfMkFZSRsoQFbn5QWzIARkNogb0O0/EK8ZUybM++Iczc2BfCL1OJLycRTArwSntBG7fh2u866YNLwQKuiIPiqfMHGOA64rBkMRdLYtzCPUI9KVi/kZoxwwTeq56R+hXFICeoZusFw5VgPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491757; c=relaxed/simple;
	bh=/8WLgKR5wjFJrUpA/ZQ4kOdLYBjqDpn/KJQ+OzXehHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDaL4L7yPNFcHuq5V6FujT4gM6Q8ti18pKHw3mmHDFssE+++rddxG/Bw5bG6NGizRDE2/Tva2/lUGxW+lkAXUotEOR5xZK8kbo96WqxNysNJC80lO59uqprrTesZ6rmOIkfC6EszhK242vePogKXNbzQvH6JxaA9hkYcpNvLZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlfcsNeD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlfcsNeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA3FC2BCF7
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 09:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778491757;
	bh=/8WLgKR5wjFJrUpA/ZQ4kOdLYBjqDpn/KJQ+OzXehHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GlfcsNeDUKVhz4/ZQU9+SQdfSg36gL5hFVfiQc4Z0zYA21UxlassSvsCPna/ZtlUH
	 jWBinOniQJeqx3mAgpeZEZilpwLFOxsVJjEXkALbc5tAGgf9SIG2r1k2b07BmIx+2C
	 uIkhf22bfPCYt7Sk9krSJBMjeGxTMSEYGFLQOe3ceuWAUeTUBVLl6S37LFecleLHvC
	 yregLvD5gTV22d1Ui5jAXv2ML2Yh/FxR/UGrmvCiSS9zvzjdIeWrkty3RVesOecJvi
	 xZN6vS8PWvK3DVGXgAhpwkJbUkgAW5IEZNJj+x00UQVj7RrhZcRBp6fLgL3qoN3MzP
	 s3K+MoMBNyd0w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a865d1547aso4675352e87.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 02:29:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9npxDcQOsioiDaHsALq1vpkat5TbVLKA+8np0I/qmfd7j4B32GtMb36Xej5yxkAMQhQ3RX1t6xOS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSuLoS7RPoO8X1bCR/rrBcYK8cm7PX6g0WVPQZPO36vvac92K
	dBrYD4Zndm2RH+op2OpmEZMn+BRG1TmMbyekfL0sROeCVQ1+qLeYg0Z2taJqHy5zJ2Sd4m3v20l
	k4YYa0Vz8eifNLirJvSefsQ5jNhmjPJM=
X-Received: by 2002:a05:6512:39c6:b0:5a8:7360:5c59 with SMTP id
 2adb3069b0e04-5a899b98095mr4948327e87.10.1778491755749; Mon, 11 May 2026
 02:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510-pm8xxx-xoadc-label-v6-0-49700fd03005@smankusors.com> <20260510-pm8xxx-xoadc-label-v6-4-49700fd03005@smankusors.com>
In-Reply-To: <20260510-pm8xxx-xoadc-label-v6-4-49700fd03005@smankusors.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 11 May 2026 11:29:02 +0200
X-Gmail-Original-Message-ID: <CAD++jLkR8HULNncaKre2jhkCfrvSGhuaNjun_WBaTK0Gib2=vw@mail.gmail.com>
X-Gm-Features: AVHnY4LOpGAki2ZZx-8fEzwB0VI2UtPd19xvaRIQQUjKadmi0IYy9LQrvAehbGc
Message-ID: <CAD++jLkR8HULNncaKre2jhkCfrvSGhuaNjun_WBaTK0Gib2=vw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] iio: adc: qcom-pm8xxx-xoadc: add support for
 reading channel labels
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	phone-devel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 9:02=E2=80=AFAM Antony Kurniawan Soemardi
<linux@smankusors.com> wrote:

> Implement the .read_label callback to allow userspace to identify ADC
> channels via the "label" property in the device tree. The name field in
> pm8xxx_chan_info is renamed to label to better reflect its purpose. If
> no label is provided in the device tree, it defaults to the hardware
> datasheet name.
>
> The change has been tested on Sony Xperia SP (PM8921).
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
