Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206241;
	b=TNuV8/pZ6fsL0dG4De3wLBknSfTUEfopYNLLDl6E5BUxpX2SX/XriLZNoToT4Os7ZEat
	 gb8/2KySVHpMxi1h0PsRm8P9VA+jDoj/6miKeA3Y555k4hdI9aP0HvXioEa6n3BiiGCU5
	 G7lGcW9IqGVaFsXneW2P6xUhQlnUjToDVaKC5236ZAhLXRvJhtE6efBfetVSAH+UrrEfZ
	 M+7vsVNPt9gIAlGV18Bc+9FV++JXIcW3GiDKJwtC6uIazys1/pbM3JYYppO3d/ixFTNtW
	 Iqcho13E5YqdLcZ1y0FSShkZ2mAUF2zDh164cPQ20UoLgrVXV20AkAyEFgaPtsHRFAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:X-Google-Original-Message-ID:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4bFPaFC4sn5I0ZmpvEnIMtoAAhYqi+gI/vKT8dEg8LI=;
	b=x9nOYiXKGHO7jJgNys5Ht5DhrHMp/NA5r+Q82YgurezZhbccA34g6RMGOoG6wcEZ3t8q
	 RXJCFP+67zFqj3DK4PtLVLbZbJ/QPPKuVecWK8NVjp/Sy8NFjLRBVu6gPNMfhXVXIq/6n
	 yuGTfWEOextwvLeoN47DiDaHlnJ8CCjgnAFLzc59E2HZD5CKsTb32phEoNF2Sk0EDkC/W
	 tu8qk9FB+j+2IXe1VDHJTxArCVuACQU5ZZgf06HJT0iKFzHxeJJIM7T35dE6MDebziEKs
	 iiPml0bCy12MtIdSdOWGIEXgITbSBNbcVxaary/Xw1P8dF+vHk/5aVH1bDmNf3sV67Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bvVViE7s;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E1606A323
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 16:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D0E1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bvVViE7s
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so13630525e9.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206239; x=1793811039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4bFPaFC4sn5I0ZmpvEnIMtoAAhYqi+gI/vKT8dEg8LI=;
        b=bvVViE7sfBqKWfi/kLDJYlnvzOUXPLQxwi7WE8YcmF6ZlMSeeXt5LVtwTgYjpBwkt8
         SYP3vMcQXr/owFcgMM1gE2QwZ/DTceP96Ogemeuc3wSVYptLjbh5WQ0zOa/QFUl5Bsyv
         t91KeRJRSejTTfSC30ERKT+SYsNtmNlFP19tG7VGrb/Fyrtxkv8HCWTMM4co1xxufiUC
         fsayYomNX2KXae5ip40Tnzxu0+b09pZZ8pnmB2UJbRFHhmlzRF7my1fWETNYJaMtDwI5
         xLbeFqSzSFzkr23lLp9iNBgX8plx3P3KNsPgixIQp18S34Dqr3UjM2Pb0SImAbIC4Wby
         52og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206239; x=1793811039;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4bFPaFC4sn5I0ZmpvEnIMtoAAhYqi+gI/vKT8dEg8LI=;
        b=Km6jUEoaCgS6hHaP1gfQqVgIn2hOeUoodjrleOnSoHUbd5K0Bj0buEJaCywNtqz7Us
         KevesH6xvwn7v5WLMyMv0BJSq2i0ZtjL+uVuJVFYO4UMU5q1ez8tn3lKy5DutgIGVDnp
         HaZfjJM/HaHkloH3+hAXpZMk1QWBk7CVRUmIUtx7W6RI/frphaX5ric1DefRyc0RtUsU
         gpLzXEVTiUqT920JCrf6E+72o/nRa9hbuDeqDlJ0SrfERtdLTRUHLlF2K6cJjyy6i+4X
         i3WXQZAS2Du27K0J+/EQHB76TYd4OnM1wgJr++mkEO7eFyIQxFK0IN4NcHSmvPG3hfHa
         hoYA==
X-Forwarded-Encrypted: i=1; AKwUvBxyRB1EffFNokhCQ83I3JniBiE7qjpLfjiQmiQiKt1KPly81zZTDKu0Ut3vGNuXuJg2YrH1qXIvEsA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7TzLIsWYgDaNOkgxu+AM+ElwaQXQklwgwjKWih3A4lXKR95z2
	z+jZxvZ+/WkDTzvt2mD5GmhS4aAGT/oEQgpnHx0gx2fonTTTWwIRTB6x
X-Gm-Gg: AYBFou2iZIn80BasxJMLZoYWQwKHacY5eETr+2LTKJ9loFe7F6tiagW1qZ8+1V0+q6Y
	uyX1Y1IxiQae8DwdK1e6u8QMMzLIi7jMBFW47tuSfYxuxSwdAW8FOQRAPqVNRVm0Hom/PmjeVV7
	IwsH013UDonvSVFztuLH+AclI1XQx1hGcmdf+9dbe3fBsusRsuihSYeI3n/JcUd3U1tv9u2Zvrf
	YDuBjRhEfWv+gTUraohu1Focu0f79KMcAGm+nbFfTSVMBGxwyoRggTQPOgb163W80RLrA0+lB8v
	a4+TTEzSL6b+sZ4xpssAxJj7iGha49lfCIZ9rpKwcBJy7MyHquzht+HtLyvJCWMHUoousVXPTU/
	2ygz8dTGivOGPl6XtdYOq2mLJ1KKIyjEaMdPMs9sxajHzWirupmPAwZ5laPfTfDn8sLviL7ogkz
	OL1AKWxujcDnKzjLtKK7ypvBDySHhtLT1CAWwWojaKECiwm4838LAYisihUBLB0Mh4Kc+X+SgdU
	8to0MwIllH+ozkshH1IUq9q4MyeoukVRND2ST1g5XUJSPynwwZfCmAAAyYK1avWdMPt64GHoMGw
	tbY+DBvIeVPjFLry3/J5enOE/cDPNfQWAd1mEJpYIVu49g6NoaNfkN3Bz48QCTk40/LgtIFDaMJ
	RfCU3CqIOqTBo5bVe
X-Received: by 2002:a05:600c:630e:b0:4a6:7d6:821f with SMTP id 5b1f17b1804b1-4a9678bff9cmr62960175e9.29.1793206238343;
        Wed, 28 Oct 2026 09:50:38 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc4d76sm29895785f8f.12.2026.10.28.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:50:37 -0700 (PDT)
Message-ID: <6ae227dd.6c7231db.220083.ae75@mx.google.com>
X-Google-Original-Message-ID: <auIn2SfzeFL2CJn-@Ansuel-XPS.>
Date: Wed, 28 Oct 2026 17:50:33 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Anholt <eric@anholt.net>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Peng Fan <peng.fan@nxp.com>,
	Aakarsh Jain <aakarsh.jain@samsung.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	freedreno@lists.freedesktop.org, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
References: <20261028120216.2657397-1-robh@kernel.org>
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
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>

On Wed, Oct 28, 2026 at 07:02:12AM -0500, Rob Herring (Arm) wrote:
> Property names within if/then schemas currently go unchecked whether
> they have a type defined or match what's in the top-level schema. Adding
> a check finds a number of instances of typos. The typos result in the
> schema having no effect on constraints.
> 
> With this, fix the mediatek,vcodec-encoder 'clocks' count constraint
> exposed by the name correction.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

For KPSS:

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel
