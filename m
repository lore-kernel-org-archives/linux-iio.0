Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9417D50B42C
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664016; cv=none; b=IFGyZUhmAw60AGqk5ufWgjKxpkddTCBLXVdfN+O8O2mSzgrCOB773mHDVs3zoL7J/qSvk7ypLUzY8uwQ8Dze4yOE/ggNKoFdkoemQco1i/p+fhj/Dq+1n76IkFo31S13BgMsUQFAkATpLeY58S5nOh44wkRAxdgTxeufndPjMmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664016; c=relaxed/simple;
	bh=QheSNJSTqInka+GwTg4+RnAArfueDQBZHVtlcFVNBTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuPs09hru/k/LGpkY+lv1glp2pa9m+kFg5X6NcAadQJMY/zAzAUdnSPbzIa5zAHKVny7trwKpRcWGvX7sz/wqzpDFs+7c1Cpkv7UPyMzENmFKer+fV18ncwzfoTcMATsYKd59tuQtCJJ8rhVJp9wmGOmO7GBbV4KqEy8sEJiIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/Qa17U6; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/Qa17U6"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a2c0356so705068b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789664013; x=1790268813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UR1otYHn7U3vnSL+rKz8JyoKuPNFmoYWrExJngJ/RnU=;
        b=p/Qa17U6sxIGxWx6lHJTqBylof+SBmUmFm2WbYsi5iGEX0FGO7RALnVcCiRkqvFQFT
         bcL0q4OO57SfL1hXg4C0gG5+iLnLxZKbZcFR2SdijdMPmGqU4d4UyhZHgtEKC8Zw1N9Z
         Siw+F6jX0RyxT2fNKDw1lZIqhPCALap4uGGCYU9ikQyU3hCylnCtXbZT0697ntYoapqC
         Tn7c+XMG04hjUZxrGNiZtzBOON6d2YSCJihak4R22v8COp2A0gAVGGExCtUUzj9hFSBM
         yjQB46wQqMWRDjWjxv5FZHZ8I+5CARG85YghrrzOEMcgSvMgd0jUtEH1UFjnuKbkTz1x
         RVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664013; x=1790268813;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UR1otYHn7U3vnSL+rKz8JyoKuPNFmoYWrExJngJ/RnU=;
        b=UCfWg2yAGAua9onxhOmRHVCsEtBIfz3+YDuuYO1fVHDL9Omdo3wR5C55wj3IHXEoin
         FLSypcy3wS9TqmtIzaI3YnTuXYyBIdCD0T6yDGvMcpuN1uon8k6bYsXWFJAnIK9d57rf
         OIr6P9q4jGj3AV6086duBKISBXrRIT6iX+K0gOX1e16H78Y82OxGKJCZYMpbv2O3ZVSR
         oswy8a9V4XU1BkPiEvBEyn8IUDMsKVBKoOsH/vC3DRcdnbgu3sMEhgLoSqJ+7uB3pz5+
         mGUw241T+7MF0yc5zeRR/PzJ5AIx0/kdBQb6TA7WouIMLDPKyPSBBe/VThLyfAeQCrft
         Q2jg==
X-Forwarded-Encrypted: i=1; AKwUvBxoHfoPar/Dw4VAF4Uv2WPtNPU6Rd0Opsaup3STtsbGoHpNQy292nWp9LeIJSVdF/apChOAR/sZQxY=@vger.kernel.org
X-Gm-Message-State: AFuF++ltUOB8HyLppZ00gYhkls67D69Koy0FKhjD73BN7FW1giVOrC03
	jwQxHTkLnnGNy1Y6OsT9e1OGNRAQS2NPEoWToSMHUYyspgcqCRhi8kYg
X-Gm-Gg: AYBFou0IRFd166gCOf1JO4/lVJk/unwiOQ84UiW2M/wwDGgZZgwF4JlKRFj69sf4I9e
	6dQCmESyQN7tIVGjk2cKcZzSpqRFoGOtZJEjAtTxYxMWyZ607bIBCV5xqXf2+Y/qHHKBAWlvfwu
	PIbeo5xFSqVmDh78ub0rm+g2rMefWD0b+uuOOdegXsomtgiE3rkZPpjpgPiYWyfQQ19L803WbyG
	KeYGS6yuXYcjZOjQ+DM2zd/2meiUbMhAMZOSOVoflGbkSCng1tDJL128Dw0B1ZLvW2mN1zDc0Jy
	Q/ugbeSEEi5Gl5hI5oLS0cgb80vGMjUjd4vAx57+lP+9//ZO1sPooPkNzyVbbhp199mMr/Crv0w
	zSYj0nXNmG/g8NKnuJ/AAbx5Q0DcIzm5OdWwy+V1cSNEv9DUxzWvY7Q6wLfwHXyXp9diVTx9adm
	fLay5H6O8r6ZmUjZwrSySI7PtFsSftY+v9E3oOfz9vI1CNtu1jUSxMaidNsKOuWqUG7J2cewTDO
	HF45y1dnWMNXx0=
X-Received: by 2002:a05:6808:4f11:b0:4b2:8ee8:8a38 with SMTP id 5614622812f47-4ca46878257mr9034077b6e.0.1789664013292;
        Thu, 17 Sep 2026 09:53:33 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cb6c80c75bsm3137159b6e.6.2026.09.17.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:53:30 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:54:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v2 09/15] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <aqwbSb2eeFaDyjLV@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
 <304d10f12a3418fbd5598160609a6eda09ed4100.1789494473.git.marcelo.schmitt@analog.com>
 <20260916160025.GA382310-robh@kernel.org>
 <20260917043039.6b9fc505@jic23-hlaptop>
 <20260917160709.GA2294753-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917160709.GA2294753-robh@kernel.org>

On 09/17, Rob Herring wrote:
> On Thu, Sep 17, 2026 at 04:30:39AM +0100, Jonathan Cameron wrote:
> > On Wed, 16 Sep 2026 11:00:25 -0500
> > Rob Herring <robh@kernel.org> wrote:
> > 
> > > On Tue, Sep 15, 2026 at 04:14:44PM -0300, Marcelo Schmitt wrote:
> > > > Document how AD4134 chips are connected to the host SPI controller
> > > > according to different wiring configurations.
> > > > 
> > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > ---
> > > > Change log v1 -> v2:
> > > > - Set default for adi,spi-mode property.
> > > > - Added '#daisy-chained-devices' property.
> > > > - Documented constraints for adi,spi-mode + #daisy-chained-devices combinations.
> > > > 
> > > >  .../bindings/iio/adc/adi,ad4134.yaml          | 51 ++++++++++++++++---
> > > >  1 file changed, 44 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > index ea6d7e026419..012e09decf7a 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > @@ -131,6 +131,26 @@ properties:
> > > >      enum: [ free-running, gated ]
> > > >      default: gated
> > > >  
> > > > +  adi,spi-mode:
> > > > +    $ref: /schemas/types.yaml#/definitions/string
> > > > +    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
> > > > +    default: no-cs
> > > > +    description: |
> > > > +      This property indicates the SPI wiring configuration.
> > > > +      * no-cs: The datasheet calls this "minimum I/O mode". In this mode, the CS
> > > > +        line is not used (tied to GND).
> > > > +      * 4-wire: Specifies a conventional SPI wiring configuration.  
> > > 
> > > Absence of this property should be conventional mode.
> > Hi Rob,
> > 
> > Unfortunately we missed this in the binding originally so we are left with the default
> > of what the driver did at the time.
> > 
> > I wouldn't be against merging a change in that default as a fix though if we
> > don't think this is yet in heavy use (merged in 7.0, but given not a complete
> > feature set yet, maybe?)
> 
I don't believe this part is being extensively used. Going with the conventional
4-wire default is the more natural choice so I'm growing my TODO list with a
note for a follow up patch to update this default.

> Ok, it's fine then. Just make sure the commit msg has this detail.

Ok, will add.


Thanks,
Marcelo
