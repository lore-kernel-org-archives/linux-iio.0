Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABB39D3FD;
	Tue,  7 Jul 2026 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394518; cv=none; b=E+7DvIU02EEzttietsb+1Yz7TPHvKKb0VEemyfDSYmDZSfR8aPZ4/nFRNQl8ExcM0Vh8EK/M9nQLBA0s889nkt6PZuPrLDnqZpeWDyDNYbY0ntn8bRVuOaGbGMD+brvAmAecjoGYpGfusJSxfbnDEdga/vsIxiuJHLz72zCOLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394518; c=relaxed/simple;
	bh=eVAbLr6C+NfHaZ2L2XDp4u04yebHxZfXEdrNs6i7+Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hd1+EsHKOXQi6Pc78YpLAOncbbQsE+njj/1THxHBNBQ6DUNnoOpfxiivd0Le8xo++9ER9yHRov9rE42d4lJcip2cEzy+/f4eeBfXv/s/+s39mWlrb26zAGR+CheXR9FhnnJlP5nOs3kNfYiWf+4ymtk9DeSgvKFHmFHj5Kra3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAOws/uO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAOws/uO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74DB1F00A3A;
	Tue,  7 Jul 2026 03:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783394517;
	bh=qRlPpYGzfzdWhO5ZLAxwkoealnp02sc5wVWp2PSsdPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NAOws/uOQG7Vg2IwXWEt4cT5CDJRWDkvn6E1psMguPWBS9q5LuHNGZmNUjGVD8POJ
	 RJycqd707Ty9iKN07WlqWGYHAc6fHZNEzuHliwet4gKhO8drVdQOcQWgBtWd/Z2lrK
	 XZgF+SCWpg5x3M/sSjp2nEQa+4DM1BzeE7Nt1ZW0qqleaZzKDigtaPmwDgg1LwZ5kt
	 +VliovQWptAgOO2rRuPb5YER3UH5tQzduYiF3CojIv5oQ7MxLzFTaUghnqAhrUyNgy
	 hk3kEK6tDavR5DJw4pchdz5wSWJm6wbzmPzUcIFktFYb1z+eXow51bpacBHKoyZJQD
	 aGr94fPOKucaQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: (subset) [PATCH v6 0/4] iio: adc: qcom-pm8xxx-xoadc: add support for reading channel labels from DT
Date: Mon,  6 Jul 2026 22:21:30 -0500
Message-ID: <178339449896.1938770.3303167541562491547.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510-pm8xxx-xoadc-label-v6-0-49700fd03005@smankusors.com>
References: <20260510-pm8xxx-xoadc-label-v6-0-49700fd03005@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 10 May 2026 07:01:29 +0000, Antony Kurniawan Soemardi wrote:
> This series adds support for reading channel labels from the device tree
> in the Qualcomm PM8xxx XOADC driver, along with the corresponding DT
> updates for the PM8921 PMIC. Also removes the redundant error logs when
> reading values, as returning -EINVAL and -ETIMEDOUT are sufficient to
> report failures.
> 
> This series also includes minor refactoring, such as removing redundant
> error loggings.
> 
> [...]

Applied, thanks!

[2/4] ARM: dts: qcom: pm8921: add labels for ADC channels
      commit: dd06f466da5247cbdcaed2bca738701b044bd8da

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
