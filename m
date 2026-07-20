Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5AD328631
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546197; cv=none; b=NSG85XFhWE4ZM3CqT26rq5ky6nqq+xtzKugi04mMdIgBm1EeA9u4Q9tm80H+IfP6cF+HWGT5VdKWrW476chrcip9Nc+kUnQHuzsbGgpqJbIMbYBhf8ckmi78Y3ePhed3x1OMUTE3ehRiNpn2pBIkrJAdU8+tdtOZ4KcNEsehJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546197; c=relaxed/simple;
	bh=KKpGEM2Q2ahnlhZRCjuVm4C6cCy/9J3lXYuDjPR8lwE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5KohhaVGRq5Z4CpROpBRX8phQWWbkU8wX8Zb4nIVojgi2rQUObRueDdKq/HQ0Bu9j7gWCWN7X/JeWDOd0aT3z18xz8ImIqKGcsa8X8m/cuMnCHHgQmfS98ViCeCurcBJnmaTBLKFYZUfF8C1IsDfmkoK8ctlHxsIDV8Th5rVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcmFVnIG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcmFVnIG"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69a5ecbbfb2so10848830a12.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784546194; x=1785150994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L/TAxliFFrN6KsYtNRi3KVvWd5AD16fwMCELbbAclZk=;
        b=pcmFVnIGKVKRm7V+AaM+frpQQH5EiPu+/in7djrE+FJJNuCXasEPSGHNx0PYVk6Ipv
         lHpv9EEaMra27arZ78QJN1Kuj0elryMYg7pZm00zZXQiT94CptgMhtulzLFKg5I0cu1q
         3w9P/0mhfj7CTv+n+ohwLvE+05HqtKaqON7Hj2ZQMP5OD6EhgwNkMTEFV5yqnMqeQeY1
         1R+aVKSJhGU+NNSQiD1NOWM/pA9cxLk0vij/CTuVaU/aXOalW7vv8bobKZ9nqk8tw7DS
         uGKh7uY8HJ+4T1jbUlaJmJ+AVntxX5W8Olcu8pJyogGm5DMnZ/15jrJbF+X3byBJGfTr
         t+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784546194; x=1785150994;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/TAxliFFrN6KsYtNRi3KVvWd5AD16fwMCELbbAclZk=;
        b=BYGp13W9vmQfbOKUoEGbAfsQuifMPtv1T3ObPk52VVaGvyhD5jO55yLzU2bbdREfaU
         6tW8f4rc9wHjO+jMKa9rzcq3EMWb3FrgE3QUXpQR6hxXw+2Qjgg8u424hOK2VskpJW71
         e2ArEY49ByJLBqYINetUxt7eHuVXqzs9IIjicWKY7Dk1jCGE30WhQkukYr8Ypi8Ba6j6
         4zc0jJArV38cSLqSaHbYjUBzpt5Suc7D9F0APxOJKdh3FKtiThCeHk2LyNabb4j8Gqh8
         wJQtSjA/U6cok8BlJX1RHGqE8cO3Q9d5pGCmAqau6WzHEDXxZOyfUawVF78zQswTXV1k
         +ftg==
X-Forwarded-Encrypted: i=1; AHgh+RpS4E2a70NxSgW3j4AkC0xC5ks6qEqyrRn0YO9grmChDuXjlbOv8Sq88IcKG9geX3SrTVbv6Hn1I4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrcImeRWqcQnRBDY51Ng4/oas2WDU4gNmB5gvWnpu4dgVTCvfj
	GJfn+9AKvO8CVtbkW7ZvaDDYwO/PxnSFucUobMzbgBDbbx/xF13iZhZkLB+vF5Ka
X-Gm-Gg: AfdE7cn85AZ0Hnqj7WsOtScbdBcP7eLiEImHiCF6n3uBEVdf5ZEog2VyNUh6DU2G7er
	S2biiwtLeSS8nG1rUd1XgPpZ1sYqCLpZXxlZf46GtB98ksyiommtH9bRwJ02Ko9eHbRfuvKCW5P
	NSJj0QvlyzcmCGRdZ315SH3fD/mr8uvYfaGb0I3IMlgshG8UureMpqNuQfuzp3lC8I/TCkdwNS8
	d/AJBemm7qVYUWZckrBt8tLUkcjvrTNayRGVy+cC5/se7HrzspCRmLa/rjX85zp4pbNjG1MGMQX
	UOA/pQnDffmZXjXiKS2zuO4FEJYxTmG5+Qc0PB3/5kC5is65ina9nlhvkbdxnrV60NacAPdm0A2
	WAkjqWedF6AK3pUYzCx2rJVuiMfT/WAuO9viNLKXCFvcHgr9Pcz3Q1FR6C3Lr6cKLQM6OpKyPEZ
	6PPmEOcAZr/xw6z0xEpIsqoGeuA6wGSgDA+O2ySPXcqofXykzkrHzxf5QEmUhGv+PJCy7qz8PXK
	Awyqw==
X-Received: by 2002:a05:6402:44da:b0:69a:af38:2fc0 with SMTP id 4fb4d7f45d1cf-69e652ddde8mr3935392a12.20.1784546194154;
        Mon, 20 Jul 2026 04:16:34 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6fff71d7sm4443075a12.27.2026.07.20.04.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:16:33 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 20 Jul 2026 12:16:29 +0100
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 3/4] iio: dac: ad5686: extend device support with new
 parts
Message-ID: <yt72xnzniqqiutxrmfbk474m6jelzfpzdc767emqiwomgxg3ez@mivshbbogi5o>
References: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
 <20260719-ad5686-extend-dev-support-v1-3-841ec75cf5d8@analog.com>
 <20260719224351.1af8aef9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719224351.1af8aef9@jic23-huawei>

On 19/07/26 22:43, Jonathan Cameron wrote:
> On Sun, 19 Jul 2026 10:51:59 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add support for AD5313R, AD5317R, AD5674, AD5679, AD5687, AD5687R, AD5689,
> > AD5689R to the AD5686 SPI driver. Also adding support for AD5316R, AD5675,
> > AD5697R to the AD5696 I2C driver. AD5673R and AD5677R were missing from
> > the of_match table.
> 
> Given I'm asking for a v2 anyway, please break out the missing of_match
> table entries as a precursor.

checkpatch complains adding stuff to of_match table without having the entry in
the dt-binding. I suppose the desired order for the changes would be:

clean ups:

- ad5696 dt-binding: adding support for the 'missing' entries.
- ad5696-i2c: add missing of_match entries
- Adjust reformat device list in file-comment headers and Kconfig

extend dev support:

- ad5686 dt-binding changes (new devices)
- ad5696 dt-binding changes (new devices)
- create new chip info's and populated device tables
- Add new devices to Kconfig option description

Does it sound reasonable?

-- 
Kind regards,

Rodrigo Alencar
