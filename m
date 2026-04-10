Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61A1A304A
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800230; cv=none; b=Tmw5UUqfugJz2wCMZudo+BF0bTOO0GYHSBgVSfKJ5//oa5CMbwD2nNNqr1uYMq6jaVjwRDb1KsSSclMxqjrEHLQgYCgzQ9+LUV4bdd8g+HbfvtrTXCZE1EVCdXacp40E/T1XjDrivEg3veWUEBSsxWjcnlZqujdKa9/XKypHZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800230; c=relaxed/simple;
	bh=mTPfpgT8nfFyakW5GjPHwbHmREoIRAfnpaQCb2yG0yE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f6JMZnOVMadKRfSxJ0KJLq7AqhzNkikf9mzNJY1/p9THcaujU+FEmg2dLV9b8g8oUAgCKVuo8SDyOnYG0wSlcxr0f577GQsV5x/fH3g/ShEq4MexYa8vm3u+Z1G5gEXZr89DWzMERwiMf+9x3RiBGO/CvbhDCpZRwKc6BjK01q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeAW9tq8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeAW9tq8"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so11183485e9.3
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 22:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775800227; x=1776405027; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3JY9f77CKP8Yny85hBL9UJZyyCOm+gzN/aKDYGQMyk=;
        b=EeAW9tq8Hg9sG8ZVGY9+7T6C8DIZnUdG0KB0+yy+WG9bUzr6e4b5znUtPhdD5yICee
         wme4xby6/XTLY4ur7Hml/T0ZuTyV2u6uDbT9NXzY7MlEdXqp68jFkwkwCf6YhbU/BRs9
         P9IGOOqS5zg+hiMY/rgJdM7GT0/F++pvKdR7sYmjH/8MgRtMgAyP0X+37bD1JZrGHU50
         xqrvpXTXgCiGSZNvy9NBXXHX6ZgEEe/nnrkTsFxAAd2NiOWpShAwuj28nYoJ7sQTXXWS
         dnB0wTLOrKKonqwoYGQ7UQUM4KiKZR6GfcwKrZhji49NJWQcUA5vFiSERI80mpqst80u
         bpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775800227; x=1776405027;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3JY9f77CKP8Yny85hBL9UJZyyCOm+gzN/aKDYGQMyk=;
        b=VclOlTnwzYjqVgrHfu7b8fRRFCembCUOE9SCqk4U7EItAnudWEiei6ZuQY1/OI+4x/
         /+S783R8knuCSzjE7TqEb6c48SwYGsaI5ifJOqtjYWIIX8luE4HwG3cY2iLHlpfE+tyP
         J6FHRdsSr0e54G3jNENuY0UXPbwcj+xW9PuNjNPmWhBm+584Y7bYpybm1McKVQAieizv
         1Hd4rex+t/5R0bV5kt2bA4x6nWatdwJyhDSXt2Vh+MB9NOz1sR9OQ6a7KgwKmTmQ1Xbm
         HO0fpj+0FtfjtuwQM9DmVni/KeB80Nf7+4bioAaWzuf2m8PdkhsUlHZB+U7ex4zWie41
         W6rg==
X-Forwarded-Encrypted: i=1; AJvYcCU75fauYHeuFtfG4Tg0bvtXIpZPB/wKsFHY6lLTyCV+LIagnErMHXxbJf/9XcjmTGKSUJfpccDgEEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzA8p74l82gtBgbCCa9XpPGQGMn6eTb3D+hspHYhKC7dH+JamN
	8Pu7XsMC00yqsEjEVNIsD5D9OiSNv3cm8xzY+9SY9CjClTS6IN8XLRCi
X-Gm-Gg: AeBDietsp5Iqgqxurbqr1sQ5w/P7PEeAkPQvw7OedfHGN8X5nvOekVvZN3BxcJiyIvH
	9qMO4KqJkvyrcGVZOt4XXxJHg3YykOcX+QqijUMEa1+aL1Iu6UDHJZYrZvwnQ58sh1kNV0KdT/p
	WcZ6V6iJThvaUivDtIuBuNmU1//gzsumyge98YRpC6SjSJjbfnVweu+Aqjl0O8zHYTmlBC9AOQY
	ftDS1N0D+1gvvG/tQDRik/0UyTRCGlTdosz7SKDCYyIFB3wbvBzLnzubqhH9vRLY5x0UH3NXInu
	jkIPJLYxdu8+QxLIOqDvLPpepUZNYAl+94E/dG5YSljvHdxpr5AbZfX1QgRTGgt8iz64dmOWoyD
	vimqoQmN9wkOxXSbaxdv2MCmT8ZHTiGrwTJ0G3rwJ/R/MNzU5NWTwR+sjNHToS5qa+wbWQJtNvi
	6VYT52NtgR01ybatMDfEo=
X-Received: by 2002:a05:600c:450a:b0:488:a882:b7 with SMTP id 5b1f17b1804b1-488d6ad17e6mr17563295e9.29.1775800226882;
        Thu, 09 Apr 2026 22:50:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d85ae9sm17892895e9.3.2026.04.09.22.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 22:50:25 -0700 (PDT)
Date: Fri, 10 Apr 2026 08:50:22 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: [bug report] iio: dac: mcp47feb02: Fix Vref validation [1-999] case
Message-ID: <adiPnla0M5EzvgD-@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ariana Lazar,

Commit dd154646d292 ("iio: dac: mcp47feb02: Fix Vref validation
[1-999] case") from Mar 10, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/iio/dac/mcp47feb02.c:1165 mcp47feb02_probe()
	error: uninitialized symbol 'vref1_uV'.

drivers/iio/dac/mcp47feb02.c
    1094 static int mcp47feb02_probe(struct i2c_client *client)
    1095 {
    1096         const struct mcp47feb02_features *chip_features;
    1097         struct device *dev = &client->dev;
    1098         struct mcp47feb02_data *data;
    1099         struct iio_dev *indio_dev;
    1100         int vref1_uV, vref_uV, vdd_uV, ret;
    1101 
    1102         indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
    1103         if (!indio_dev)
    1104                 return -ENOMEM;
    1105 
    1106         data = iio_priv(indio_dev);
    1107         chip_features = i2c_get_match_data(client);
    1108         if (!chip_features)
    1109                 return -EINVAL;
    1110 
    1111         data->chip_features = chip_features;
    1112 
    1113         if (chip_features->have_eeprom) {
    1114                 data->regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
    1115                 indio_dev->info = &mcp47feb02_info;
    1116         } else {
    1117                 data->regmap = devm_regmap_init_i2c(client, &mcp47fvb02_regmap_config);
    1118                 indio_dev->info = &mcp47fvb02_info;
    1119         }
    1120         if (IS_ERR(data->regmap))
    1121                 return dev_err_probe(dev, PTR_ERR(data->regmap), "Error initializing i2c regmap\n");
    1122 
    1123         indio_dev->name = chip_features->name;
    1124 
    1125         ret = mcp47feb02_parse_fw(indio_dev, chip_features);
    1126         if (ret)
    1127                 return dev_err_probe(dev, ret, "Error parsing firmware data\n");
    1128 
    1129         ret = devm_mutex_init(dev, &data->lock);
    1130         if (ret)
    1131                 return ret;
    1132 
    1133         ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
    1134         if (ret < 0)
    1135                 return ret;
    1136 
    1137         vdd_uV = ret;
    1138 
    1139         ret = devm_regulator_get_enable_read_voltage(dev, "vref");
    1140         if (ret > 0) {
    1141                 vref_uV = ret;
    1142                 data->use_vref = true;
    1143         } else {
    1144                 vref_uV = 0;
    1145                 dev_dbg(dev, "using internal band gap as voltage reference.\n");
    1146                 dev_dbg(dev, "Vref is unavailable.\n");
    1147         }
    1148 
    1149         if (chip_features->have_ext_vref1) {
    1150                 ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
    1151                 if (ret > 0) {
    1152                         vref1_uV = ret;
    1153                         data->use_vref1 = true;
    1154                 } else {
    1155                         vref1_uV = 0;
    1156                         dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
    1157                         dev_dbg(dev, "Vref1 is unavailable.\n");
    1158                 }
    1159         }

vref1_uV is uninitialized if ->have_ext_vref1 is false.

    1160 
    1161         ret = mcp47feb02_init_ctrl_regs(data);
    1162         if (ret)
    1163                 return dev_err_probe(dev, ret, "Error initialising vref register\n");
    1164 
--> 1165         ret = mcp47feb02_init_ch_scales(data, vdd_uV, vref_uV, vref1_uV);

Passing uninitialized variables is not allowed even if the variable
is not used.  (Unless the function is inlined and then it's not really
"passing" anything is it?)

    1166         if (ret)
    1167                 return ret;
    1168 
    1169         return devm_iio_device_register(dev, indio_dev);
    1170 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
