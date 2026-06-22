Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E43A543A
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124120; cv=none; b=JOwMPRjVO1Dj4yk1pplNa5AsWLp+MRxQRDf6uNAONXx9iUb3RciKqQJvGmrv2Zz/bgLG9x9T4hWt9WK5PhH+44TVq/S91SQkW++qedCQRO/kqKxtjA71ju3XP/WM6eiVLbhyRbMZTkrK38rYi1rR8I+7fIyXaIQOuuJQQIMxc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124120; c=relaxed/simple;
	bh=Nzj1hBDIaNgSfD2WN24RcH2I3yNg/H9h8m6TxZL0q9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojrROApgDx3udkfxdBGbPiNBvuJYONOa/xaRnb4XmuT4DhWilynZuJdf1EFE/XENoBDcZ7hcMguZAHMl8DGAMeo+dfg5rGFpLwwzavn65naEXXYcyH9eMyf5Ckb0iDqVZYg3mUmb3dBOpSl5/Dpbq+w0ryaAA4nsEWy88eOGVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/W2x2bv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/W2x2bv"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4602e2a0372so3288691f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 03:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782124117; x=1782728917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MSKYgJHO96sMy9Hm0C9wampvV++OGf1wyk2MLZdNP9o=;
        b=V/W2x2bvCnMX8uRrVoDGxBI+2UDrtdk0aGA3iE8JVW8zGNbu8jdtEHXy5vDeQtMhKZ
         eraJSlxAY9ONCX6q3oh00P0o4M3sk+gjA0KNe2/gO/vhBDXMcQlJXt6Vz5FLPTX0MO+j
         yMDalrITrHZbVzyNgHPprH198xvG1ceWECBog5KmQrgjaSpeWWHOEMp4pqJoR4UuHb/L
         MuMl/7hLDa5ZAefkSeY8bpdIbQm1jk8sOmtbov7K7J3Zm2alRc69rRKOrjLV1ujVK76a
         IlKExUNJktsrmemImqh3bafN52+FBEc+pz6teJeowbBi61KQBHG+/LhsfBfw2BigJtjz
         WuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782124117; x=1782728917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSKYgJHO96sMy9Hm0C9wampvV++OGf1wyk2MLZdNP9o=;
        b=NwBDmhPrBAYaLteijm5SD7mRulYPTM8CKk8pIsxeaZ/3Li2Dfrm+7b6ALtnxbnffjh
         S1tAh7qNRY4YRfVOEx7Up8QuK5xHNtCOU9FJq7dCSQrV5KUcwg1DVikAj/qM5TCjHWA7
         3gCfBc+ojJPS+yAp8Zdkt361ZpbkRzjG6Yim9Q9gD2sRjiErbseEOp9w79OT+OhH7Ti6
         WCLe9mGUJTUmmP3gU05psiv6sCVLjI87DCTglBi3Dak/g1tzu8RW7BUKv+fCt3kOE+Um
         lFCxXyiIU/f5IChisS0c27ARe0GMF3t5xSsa3wiyxZRRzRbgfoNYD041y1DEaeNBm5c7
         cJNQ==
X-Forwarded-Encrypted: i=1; AHgh+RoF6ylKtCoRMczXGYx+kzWEbSd/AzgDUs/v7DcVYBjmJ7qEkxUdkL+mQZj4rzSoBQ2J3l+kzt7/+Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KE1RnAngZlV9lq1mTa2rYPWt3ta+dq1Jc0C9lsNSZHan8KDw
	LQjD4pkEC1WLEI9fzCJCtWKhlbjPqAY/KaS8OPtI4Jmhv9xYUsiP5f2s1S6PFQ==
X-Gm-Gg: AfdE7ckS4/vcUPfUxC1qx0lL1Cv4LxAXj/5DuDbo/mrg0ZLaaz7Rl6QfwoV+pIG9Fan
	aGXGUVCdsYATut7NIJfym0zjdFxmnZcSAnS55TVqF3YoFbvollje8qffd9HjEzufvhJvez7tMfL
	oDfZ7wJYCg9TXDbAUqiDIMYtKxjflSAxER2HkP4JV/M3+B4UHD3F0JnOqBSv1ncZqnSS13BsbaN
	v54Cjdu1udGhaAvIHhyU+v7ujg+rE1G+UL4fz8ZReT/9wv5PKhvB4QH5Ezt2mOUnLAl49csE87X
	YyVoaAUVE9uuB4njxctRPZWyyMVCmDqSSrMnBnpxOh1BzFay5JjF4kulqbFfOjACe1Lo6CDhKi4
	ERT9fAYx1HPjhCByUUtB3rXbjr3w9keoK1xlvGn/kjYzO+ZYpV9ZXa9NFqpk2VrKr331MrNb8t0
	X70Sp6
X-Received: by 2002:a05:6000:4687:b0:465:8fc5:7f1f with SMTP id ffacd0b85a97d-4658fc58a4fmr12474677f8f.38.1782124116676;
        Mon, 22 Jun 2026 03:28:36 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c579dfsm24897175f8f.31.2026.06.22.03.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 03:28:36 -0700 (PDT)
Date: Mon, 22 Jun 2026 11:29:38 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Janani Sunil <jan.sun97@gmail.com>, Janani Sunil <janani.sunil@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <ajkMBh-R_7pYaoAn@nsa>
References: <603473ac-30e6-45e5-8a3b-c9902715cc9e@gmail.com>
 <20260614204455.408c4d40@jic23-huawei>
 <076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
 <20260619-obstinate-polo-a230bef97fda@spud>
 <20260619-bunch-diocese-dd7805cc17ff@spud>
 <ajU73_TkKrSbqD4f@nsa>
 <20260619-concierge-doozy-9c161533c369@spud>
 <ajVlD-j0nIGrRVow@nsa>
 <20260621153330.79b6600c@jic23-huawei>
 <5u4dnsgxwcwie45f24cacyzf3dko4srhyyyhcpom6tsvhqtmpc@y7d7gmex6n7k>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5u4dnsgxwcwie45f24cacyzf3dko4srhyyyhcpom6tsvhqtmpc@y7d7gmex6n7k>

On Mon, Jun 22, 2026 at 10:24:05AM +0100, Rodrigo Alencar wrote:
> On 21/06/26 15:33, Jonathan Cameron wrote:
> > On Fri, 19 Jun 2026 16:54:11 +0100
> > Nuno Sá <noname.nuno@gmail.com> wrote:
> > 
> > > On Fri, Jun 19, 2026 at 03:12:07PM +0100, Conor Dooley wrote:
> > > > On Fri, Jun 19, 2026 at 02:01:08PM +0100, Nuno Sá wrote:  
> > > > > On Fri, Jun 19, 2026 at 12:40:54PM +0100, Conor Dooley wrote:  
> > > > > > On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Dooley wrote:  
> > > > > > > On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Sunil wrote:  
> > > > > > > > 
> > > > > > > > On 6/14/26 21:44, Jonathan Cameron wrote:  
> > > > > > > > > On Tue, 9 Jun 2026 16:47:23 +0200
> > > > > > > > > Janani Sunil <jan.sun97@gmail.com> wrote:
> > > > > > > > >   
> > > > > > > > > > On 5/26/26 15:11, Rodrigo Alencar wrote:  
> > > > > > > > > > > On 26/05/19 05:42PM, Janani Sunil wrote:  
> > > > > > > > > > > > Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> > > > > > > > > > > > buffered voltage output digital-to-analog converter (DAC) with an
> > > > > > > > > > > > integrated precision reference.  
> > > > > > > > > > > ...
> > > > > > > > > > > Probably others may comment on that, but...
> > > > > > > > > > > 
> > > > > > > > > > > This parent node may support device addressing for multi-device support through
> > > > > > > > > > > those ID pins. I suppose that each device may have its own power supplies or
> > > > > > > > > > > other resources like the toggle pins or reset and enable.
> > > > > > > > > > > 
> > > > > > > > > > > That way I suppose that an example would look like...  
> > > > > > > > > > > > +
> > > > > > > > > > > > +patternProperties:
> > > > > > > > > > > > +  "^channel@([0-9]|1[0-5])$":
> > > > > > > > > > > > +    type: object
> > > > > > > > > > > > +    description: Child nodes for individual channel configuration
> > > > > > > > > > > > +
> > > > > > > > > > > > +    properties:
> > > > > > > > > > > > +      reg:
> > > > > > > > > > > > +        description: Channel number.
> > > > > > > > > > > > +        minimum: 0
> > > > > > > > > > > > +        maximum: 15
> > > > > > > > > > > > +
> > > > > > > > > > > > +      adi,output-range-microvolt:
> > > > > > > > > > > > +        description: |
> > > > > > > > > > > > +          Output voltage range for this channel as [min, max] in microvolts.
> > > > > > > > > > > > +          If not specified, defaults to 0V to 5V range.
> > > > > > > > > > > > +        oneOf:
> > > > > > > > > > > > +          - items:
> > > > > > > > > > > > +              - const: 0
> > > > > > > > > > > > +              - enum: [5000000, 10000000, 20000000, 40000000]
> > > > > > > > > > > > +          - items:
> > > > > > > > > > > > +              - const: -5000000
> > > > > > > > > > > > +              - const: 5000000
> > > > > > > > > > > > +          - items:
> > > > > > > > > > > > +              - const: -10000000
> > > > > > > > > > > > +              - const: 10000000
> > > > > > > > > > > > +          - items:
> > > > > > > > > > > > +              - const: -15000000
> > > > > > > > > > > > +              - const: 15000000
> > > > > > > > > > > > +          - items:
> > > > > > > > > > > > +              - const: -20000000
> > > > > > > > > > > > +              - const: 20000000
> > > > > > > > > > > > +
> > > > > > > > > > > > +    required:
> > > > > > > > > > > > +      - reg
> > > > > > > > > > > > +
> > > > > > > > > > > > +    additionalProperties: false
> > > > > > > > > > > > +
> > > > > > > > > > > > +required:
> > > > > > > > > > > > +  - compatible
> > > > > > > > > > > > +  - reg
> > > > > > > > > > > > +  - vdd-supply
> > > > > > > > > > > > +  - avdd-supply
> > > > > > > > > > > > +  - hvdd-supply
> > > > > > > > > > > > +
> > > > > > > > > > > > +dependencies:
> > > > > > > > > > > > +  spi-cpha: [ spi-cpol ]
> > > > > > > > > > > > +  spi-cpol: [ spi-cpha ]
> > > > > > > > > > > > +
> > > > > > > > > > > > +allOf:
> > > > > > > > > > > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > > > > > > > > +
> > > > > > > > > > > > +unevaluatedProperties: false
> > > > > > > > > > > > +
> > > > > > > > > > > > +examples:
> > > > > > > > > > > > +  - |
> > > > > > > > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > > > > > > > +
> > > > > > > > > > > > +    spi {
> > > > > > > > > > > > +        #address-cells = <1>;
> > > > > > > > > > > > +        #size-cells = <0>;
> > > > > > > > > > > > +
> > > > > > > > > > > > +        dac@0 {
> > > > > > > > > > > > +            compatible = "adi,ad5529r-16";
> > > > > > > > > > > > +            reg = <0>;
> > > > > > > > > > > > +            spi-max-frequency = <25000000>;
> > > > > > > > > > > > +
> > > > > > > > > > > > +            vdd-supply = <&vdd_regulator>;
> > > > > > > > > > > > +            avdd-supply = <&avdd_regulator>;
> > > > > > > > > > > > +            hvdd-supply = <&hvdd_regulator>;
> > > > > > > > > > > > +            hvss-supply = <&hvss_regulator>;
> > > > > > > > > > > > +
> > > > > > > > > > > > +            reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > > > > > > > +
> > > > > > > > > > > > +            #address-cells = <1>;
> > > > > > > > > > > > +            #size-cells = <0>;
> > > > > > > > > > > > +
> > > > > > > > > > > > +            channel@0 {
> > > > > > > > > > > > +                reg = <0>;
> > > > > > > > > > > > +                adi,output-range-microvolt = <0 5000000>;
> > > > > > > > > > > > +            };
> > > > > > > > > > > > +
> > > > > > > > > > > > +            channel@1 {
> > > > > > > > > > > > +                reg = <1>;
> > > > > > > > > > > > +                adi,output-range-microvolt = <(-10000000) 10000000>;
> > > > > > > > > > > > +            };
> > > > > > > > > > > > +
> > > > > > > > > > > > +            channel@2 {
> > > > > > > > > > > > +                reg = <2>;
> > > > > > > > > > > > +                adi,output-range-microvolt = <0 40000000>;
> > > > > > > > > > > > +            };
> > > > > > > > > > > > +        };
> > > > > > > > > > > > +    };  
> > > > > > > > > > > ...
> > > > > > > > > > > 
> > > > > > > > > > > 	spi {
> > > > > > > > > > > 		#address-cells = <1>;
> > > > > > > > > > > 		#size-cells = <0>;
> > > > > > > > > > > 
> > > > > > > > > > > 		multi-dac@0 {
> > > > > > > > > > > 			compatible = "adi,ad5529r-16";
> > > > > > > > > > > 			reg = <0>;
> > > > > > > > > > > 			spi-max-frequency = <25000000>;
> > > > > > > > > > > 
> > > > > > > > > > > 			#address-cells = <1>;
> > > > > > > > > > > 			#size-cells = <0>;
> > > > > > > > > > > 
> > > > > > > > > > > 			dac@0 {
> > > > > > > > > > > 				reg = <0>;
> > > > > > > > > > > 				vdd-supply = <&vdd_regulator>;
> > > > > > > > > > > 				avdd-supply = <&avdd_regulator>;
> > > > > > > > > > > 				hvdd-supply = <&hvdd_regulator>;
> > > > > > > > > > > 				hvss-supply = <&hvss_regulator>;
> > > > > > > > > > > 
> > > > > > > > > > > 				reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > > > > > > 
> > > > > > > > > > > 				#address-cells = <1>;
> > > > > > > > > > > 				#size-cells = <0>;
> > > > > > > > > > > 
> > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > 					reg = <0>;
> > > > > > > > > > > 					adi,output-range-microvolt = <0 5000000>;
> > > > > > > > > > > 				};
> > > > > > > > > > > 
> > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > 					reg = <1>;
> > > > > > > > > > > 					adi,output-range-microvolt = <(-10000000) 10000000>;
> > > > > > > > > > > 				};
> > > > > > > > > > > 
> > > > > > > > > > > 				channel@2 {
> > > > > > > > > > > 					reg = <2>;
> > > > > > > > > > > 					adi,output-range-microvolt = <0 40000000>;
> > > > > > > > > > > 				};
> > > > > > > > > > > 			}
> > > > > > > > > > > 
> > > > > > > > > > > 			dac@1 {
> > > > > > > > > > > 				reg = <1>;
> > > > > > > > > > > 				vdd-supply = <&vdd_regulator>;
> > > > > > > > > > > 				avdd-supply = <&avdd_regulator>;
> > > > > > > > > > > 				hvdd-supply = <&hvdd_regulator>;
> > > > > > > > > > > 				hvss-supply = <&hvss_regulator>;
> > > > > > > > > > > 
> > > > > > > > > > > 				reset-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
> > > > > > > > > > > 
> > > > > > > > > > > 				#address-cells = <1>;
> > > > > > > > > > > 				#size-cells = <0>;
> > > > > > > > > > > 
> > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > 					reg = <0>;
> > > > > > > > > > > 					adi,output-range-microvolt = <0 5000000>;
> > > > > > > > > > > 				};
> > > > > > > > > > > 
> > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > 					reg = <1>;
> > > > > > > > > > > 					adi,output-range-microvolt = <(-10000000) 10000000>;
> > > > > > > > > > > 				};
> > > > > > > > > > > 			}
> > > > > > > > > > > 		};
> > > > > > > > > > > 	};
> > > > > > > > > > > 
> > > > > > > > > > > then you might need something like:
> > > > > > > > > > > 
> > > > > > > > > > > 	patternProperties:
> > > > > > > > > > > 		"^dac@[0-3]$":
> > > > > > > > > > > 
> > > > > > > > > > > and put most of the things under this node pattern.
> > > > > > > > > > > 
> > > > > > > > > > > So the main driver that you're putting together might need to handle up to four instances.
> > > > > > > > > > > Even if your current driver cannot handle this, the dt-bindings might need cover that.
> > > > > > > > > > > 
> > > > > > > > > > > Need to double check if each dac node needs a separate compatible, so you would maybe populate
> > > > > > > > > > > a platform data to be shared with the child nodes, which would be a separate driver.
> > > > > > > > > > > (not sure if it would make sense to mix and match ad5529r-16 and ad5529r-12).  
> > > > > > > > > > Hi Rodrigo,
> > > > > > > > > > 
> > > > > > > > > > Thank you for looking at this.
> > > > > > > > > > 
> > > > > > > > > > For now, I would prefer to keep the binding scoped to a single AD5529R device instance. The current
> > > > > > > > > > hardware/use case we have only needs one device node and the driver is written around that model as well.
> > > > > > > > > > While the device addressing pins could allow multi-device topology, we do not have an actual platform using
> > > > > > > > > > that configuration at the moment, so I would prefer not to introduce an extra parent/child binding structure
> > > > > > > > > > speculatively without a validating use case.  
> > > > > > > > > Interesting feature - kind of similar to address control on a typical i2c bus device, or
> > > > > > > > > looking at it another way a kind of distributed SPI mux.
> > > > > > > > > 
> > > > > > > > > Challenge of a binding is we need to anticipate the future.  So I think we do need something
> > > > > > > > > like Rodrigo is suggesting even if we only (for now) support a single instance in the driver.
> > > > > > > > > That would leave the path open to supporting the addressing at a later date.
> > > > > > > > > An alternative might be to look at it like a chained device setup. In those we pretend there
> > > > > > > > > is just one device with a lot of channels etc.  The snag is that here things are more loosely
> > > > > > > > > coupled whereas for those devices it tends to be you have to read / write the same register
> > > > > > > > > in all devices in the chain as one big SPI message.
> > > > > > > > > 
> > > > > > > > > +CC Mark Brown as he may know of some precedence for this feature. For his reference..
> > > > > > > > > - Each of these device has 2 ID pins.  The SPI transfers have to contain the 2 bit
> > > > > > > > > value that matches that or they are ignored.  Thus a single bus + 1 chip select can
> > > > > > > > > be used to talk to 4 devices.  Question is what that looks like in device tree + I guess
> > > > > > > > > longer term how to support it cleanly in SPI.  
> > > > > > > 
> > > > > > > I'd swear I have seen this before, from some Microchip devices. Let me
> > > > > > > see if I can find what I am thinking of...  
> > > > > > 
> > > > > > 
> > > > > > microchip,mcp3911 and microchip,mcp3564 both seem to do this with
> > > > > > slightly different properties.
> > > > > > 
> > > > > >   microchip,device-addr:
> > > > > >     description: Device address when multiple MCP3911 chips are present on the same SPI bus.
> > > > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > > > >     enum: [0, 1, 2, 3]
> > > > > >     default: 0
> > > > > > 
> > > > > > and
> > > > > > 
> > > > > > 
> > > > > >   microchip,hw-device-address:
> > > > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > > > >     minimum: 0
> > > > > >     maximum: 3
> > > > > >     description:
> > > > > >       The address is set on a per-device basis by fuses in the factory,
> > > > > >       configured on request. If not requested, the fuses are set for 0x1.
> > > > > >       The device address is part of the device markings to avoid
> > > > > >       potential confusion. This address is coded on two bits, so four possible
> > > > > >       addresses are available when multiple devices are present on the same
> > > > > >       SPI bus with only one Chip Select line for all devices.
> > > > > >       Each device communication starts by a CS falling edge, followed by the
> > > > > >       clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
> > > > > >       which is first one on the wire).
> > > > > > 
> > > > > > This sounds exactly like the sort of feature that you're dealing with
> > > > > > here?
> > > > > >   
> > > > > 
> > > > > The core idea yes but for this chip, things are a bit more annoying (but
> > > > > Janani can correct me if I'm wrong). Here, each device can, in theory,
> > > > > have it's own supplies, pins and at the very least, channels with maybe
> > > > > different scales. That is why Janani is proposing dac nodes. Given I
> > > > > honestly don't like much of that "adi,ad5529r-bus" compatible I wondered
> > > > > about solving this at the spi level.
> > > > > 
> > > > > Ah and to make it more annoying, we can also mix 12 and 16 bits variants
> > > > > together in the same bus.  
> > > > 
> > > > I'm definitely missing something, because that property for the
> > > > microchip devices is not impacted what else is on the bus. AFAICT, you
> > > > could have an mcp3911 and an mcp3564 on the same bus even though both
> > > > are completely different devices with different drivers. They have
> > > > individual device nodes and their own supplies etc etc. These aren't
> > > > per-channel properties on an adc or dac, they're per child device on a
> > > > spi bus.  
> > > 
> > > Maybe I'm the one missing something :). IIRC, spi would not allow two
> > > devices on the same CS right? Because for this chip we would need
> > > something like:
> > > 
> > > spi {
> > > 	dac@0 {
> > > 		reg = <0>;
> > > 		adi,pin-id = <0>;
> > > 	};
> > > 
> > > 	dac@1 {
> > > 		reg = <0>; // which seems already problematic?
> > > 		adi,pin-id <1>;
> > > 	};
> > > 
> > > 	...
> > > 
> > > 	//up to 4
> > > };
> > Yeah. It's not clear to me how that works for the microchip devices
> > (I suspect it doesn't!)
> > 
> > Just thinking as I type, but could we do something a bit nasty with
> > a gpio mux that doesn't actually switch but represents the GPIO being
> > shared?  Given this is all tied to the spi bus that should all happen
> > under serializing locks. 
> > 
> > Agreed though that this would be nicer as an SPI thing that let
> > us specify that a single CS is share by multiple devices and their
> > is some other signal acting to select which one we are talking to.
> > 
> 
> If the device-addressing on the same chip-select is to be handled
> by the spi framework, wouldn't we lose device-specific features?
> 
> I understand that this multi-device feature is there mostly to extend the
> channel count from 16 to 32, 48 or 64. I suppose the command:
> 
> 	"MULTI DEVICE SW LDAC MODE"
> 
> exists so that software can update channel values accross multiple devices.

Right! You do have a point! I agree the main driver for a feature like
this is likely to extend the channel count and effectively "aggregate"
devices.

But I would say that even with the spi solution the MULTI DEVICE stuff
should be doable (as we still need a sort of adi,pin-id property). 

But yes, I do feel that the whole feature is for aggregation so seeing
one device with 32 channels is the expectation here? Rather than seeing
two devices with 16 channels.

- Nuno Sá

> 
> -- 
> Kind regards,
> 
> Rodrigo Alencar
