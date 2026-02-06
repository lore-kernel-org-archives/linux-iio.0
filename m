Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9C36CE02
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385220; cv=none; b=pIyrvX6OrmR8GpS4lvrNMQ7vqMtZlrY0ar430JGkQV2bkUxi1ptU0jObCGf35cs+UoI/wNWs8ZU3Lt7KTKPr1tNJR3U8cBczsUkgbvcNBUYBdwspeyC+iWbU+YHj4OnWJQRguCiHfiUt3csLOAKkEfooIoFMKABxDK3/p4O2Xko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385220; c=relaxed/simple;
	bh=ATlhFGS0epSOhWwfAmwesm2WZpZ/6TNmM7ADuJJY0qg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pMeuDRlKayojS9m44tERpO9jvy1S+Saa5aBVge6ieH1B6z28+48olfOwZ4G5VMHyhbi0oxgg0Wjt954bwYdBNAm5nfnkdw2iIDT9m+hFlSb4PofWw6fcRuv0XMq+bTOZ/2yvo8v+wCTNWtYB7B/nAMR2FrOTp5oKOV7krHAXqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xXYnThNv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXYnThNv"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-435f177a8f7so763256f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 05:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385219; x=1770990019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZEaDFtgFd37DlJ4dWpEVneMMIpWVukSb9jk36O2nM4=;
        b=xXYnThNvDNlyJjQjAH3smf0o6mRv+HAM7DeNZtlMBNhHnSgZmMyv6+qxp0SIQrMowJ
         6jy1kkW2g+bnbape2o9jpz9C+Ki700SSs+4D0Uw8wIeuqHIBJtJWH1C8lpv98JH0oJfi
         +F9cN5tx7jQek/szBwzQ8Y/fXKmSm0zlkYWnZmjlel+S8F1aLzM4/l6xC3IwfCTMyBfs
         je8haMIiWxKxJJ5VOar9lVWO252IRb0721ZyLqDLY61W9px/QQUyffixS/cUzfuUdXjT
         I6MsbKnBGoorC6R91Yf4eVjt84OTBoPmPAw7QQZsLkwugmSU15ESr5uB6nk0cFLSujub
         H7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385219; x=1770990019;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZEaDFtgFd37DlJ4dWpEVneMMIpWVukSb9jk36O2nM4=;
        b=pFPr6NjJmCnD9CdGnIJRMNuUTH/oxVGUxwghQfZrkgIXHWroCbqWwEz09TR73KKEiC
         tiKAgBNuZtEfgRioFD4/NBbG6Owaxp/FgJYFRlGjSMzRBuooldibPyze5gLL48p2rrwC
         9g6BmEcPSgURvoXqmXVWcVJPTnOSvdfTpts+lJ/zu4bKnLcaglM0DTM7yYhUIT8goL5G
         SeyDLOC5vm25jtO4QaYSY2MtOievgHjPfq9D3W+2W/QshfIVyVa+ufCj37co35TuSOAg
         PXoSXYFAzGlMt42dKhSBZJlJ/kq8KJNYt1Fjkcx7SEdJ/kk2HrwCjdIzgr/DpaZ7pCNS
         XxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYLug4FrAH16MAosWs+Xx3DmYWFMydk4c+XgVomlghHza+sNXgSDh1tfhfry9HEG6mmr4YgKER+/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHFse8qdB9dR++CQXWaduFJ9XY4fufcRuUEerBpchp667n43b
	YBiFBgn7TNjbEJPbcwfNN0dNrrewgmkIBnUZqA2mA2Yi8GgiSH16SKBNXeBXI4S3vK4=
X-Gm-Gg: AZuq6aJ0fT0u54acL4BanZvWiP1l+U7ijgLv7IkyhugjM+vMRKz3QbFAVCh+zahoWAa
	9Mr/xWZmE9tq6U4zFeZPJlnPMGU3oXhk226LewfAuT9pOBmaMKko1N5fiT0YCFnXsfk+BbYZVOD
	zS4GB9DkKYItLiVC9XPh9EqGCeZx0LoHFjAHvQo5sK58ZpIA+CBq6i1UKnB9u6f3EPR8LnS9NDk
	Q7BJhUmTIscD32bo4mtHvnzTNriGlLVV7wtGRr+K07rpPB6UsuHvOHtHzPQ2M8xjNcRfJPw4NSU
	Him3GhlWwnt78yNK3tZhompRv/jAYqhAEsr7gJgObxi3eXeMCsjGUP5vfWfXnS4dX0V16hsU284
	oh7p2enUWkzx4cgIp8WzvoS0ypcPQUOILG4bqFz58r+Iuelya2JAWpxZoyqAlWA+pyowgTKaPwZ
	sjB7+b2dkj7qKSyQqh
X-Received: by 2002:a05:6000:1a87:b0:436:233c:c7c0 with SMTP id ffacd0b85a97d-43629342249mr4824596f8f.26.1770385218723;
        Fri, 06 Feb 2026 05:40:18 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd3b8sm5896607f8f.11.2026.02.06.05.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:40:18 -0800 (PST)
Date: Fri, 6 Feb 2026 16:40:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <aYXvP5FLA5BvkoVX@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Ariana Lazar,

Commit bf394cc80369 ("iio: dac: adding support for Microchip
MCP47FEB02") from Dec 16, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/iio/dac/mcp47feb02.c:732 mcp47feb02_init_scales_avail()
	warn: passing zero to 'dev_err_probe'

drivers/iio/dac/mcp47feb02.c
    712 static int mcp47feb02_init_scales_avail(struct mcp47feb02_data *data, int vdd_mV,
    713                                         int vref_mV, int vref1_mV)
    714 {
    715         struct device *dev = regmap_get_device(data->regmap);
    716         int tmp_vref;
    717 
    718         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale);
    719 
    720         if (data->use_vref)
    721                 tmp_vref = vref_mV;
    722         else
    723                 tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;
    724 
    725         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1, tmp_vref, data->scale);
    726         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2, data->scale);
    727 
    728         if (data->phys_channels >= 4) {
    729                 mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale_1);
    730 
    731                 if (data->use_vref1 && vref1_mV <= 0)
--> 732                         return dev_err_probe(dev, vref1_mV, "Invalid voltage for Vref1\n");
                                                          ^^^^^^^^
vref1_mV is not a valid error code.  Return -EINVAL.

    733 
    734                 if (data->use_vref1)
    735                         tmp_vref = vref1_mV;
    736                 else
    737                         tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;
    738 
    739                 mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1,
    740                                       tmp_vref, data->scale_1);
    741                 mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2,
    742                                       tmp_vref * 2, data->scale_1);
    743         }
    744 
    745         return 0;
    746 }

regards,
dan carpenter
