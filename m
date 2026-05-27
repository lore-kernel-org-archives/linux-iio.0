Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5674266AE
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892525; cv=none; b=dDoDKP7UDJW9i6rYMZvnVyMm3ATE10Od1CkW+fMllR9Q3flF8gGSkEA1QlSk+eklfAmNgkuZBfTcJrut1lmOrcge0FJ8B8gcu4VLkZO/WLHDrEHxvCwAW8vC1bE+wv5bZ+pB3IENCr6ZPhSVlgM/JWSYGjGflWFCVKhBPHVhf8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892525; c=relaxed/simple;
	bh=Sg2dysRu4arnhharl9K85XjeLUmzUHS/CAFhi2sXB/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef2QVLjl3H+yUg1hkk2ptscx1ForEP3wGj95pz1zMO6z6Qg/Z/kXBJgpty7azaoB2F70ip3csrigAYWFv1xxtsHphNRU4DWHkrIYyojvVcYx0bvxICg58VbQHlBQm4fG5sMmf+PTA7yOOTRDfs8pmZ+YhFL9rgWDjkG8S2URX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMvTZX7F; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMvTZX7F"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so7157139f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779892522; x=1780497322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkNcbsQeAXbT5DQ68OCTzTS3XT0QLF4nJ4lJuUAvyTQ=;
        b=PMvTZX7F9Koh2kBY+1ZI8l6ls00q5VBlXxoEGROk9BA55FMxzCUdeS0Kfuiyx24nDu
         FYYkBwTxGaRCtxlvX95tTY403wnUz82wgOhJpoJOElwWdEZmsaG5WTD0gH1LyNEIHNt3
         3CEcXsn/utBzXmGWOu67h0tfr2U4SM0tH8xBrLDWmyYQsFlFSfVkd6srb6vEQXqRlv7s
         HvB+fRzlL7OWT7gZGBwTgGfPxVR+GD8xc1KOdel8L8J1TucXgQdq16F4SOxHKeG09yHY
         403DN+wjq5/FdO4y5wI1bGKWNzWDMjJv9M9Dd8sZHbZrBkIG3YtdGFv7NgzxdQZqT3TE
         cedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892522; x=1780497322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FkNcbsQeAXbT5DQ68OCTzTS3XT0QLF4nJ4lJuUAvyTQ=;
        b=fDsJfg+7WtGUbfAlOfUjrFCwRHXfd/Bo6sJn/KW/PK079iEJV12fxnksZthNsOSKse
         k5TuA4ZzflDZpMNYzNm5S0TdrxnqAMfog/V8Mmbfm/xjHJQFdovSMump5zLV07MB0L88
         vgX93rRQ6vaSUa8/2fmVBriMQfdpWnrfnwrRYAD8pTHs1r2Lbf9fXtzSmEEuB5hyymjm
         QW93knlfzrE98hXaI9skg2wmQwDpip1JrGEmURA0wPu+nw2IMLGoV66pf776nl3Vd+HQ
         u0MHkehEVpbpVmqO6Knlv+/11DTOHexdklMa0tmIW0ARd2XUozbvPCkF134c8Zl1STcA
         E6Lg==
X-Forwarded-Encrypted: i=1; AFNElJ8XrQtdl0cg2qMsba6ATOg4ryZv5+vyU+ckJ05BWig7nscomrHDF+d6pLobkLqHTL7Rsq4WYGaJdS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3uQ0pux6qg+IDsWE6psb7NjugXU6E97ctCQD+3OjRG0xeV7Z+
	pJJNn1y8clriOp/DCmQaD5l3BQH9lCfFiiQ8Ff5LA+Ks8tlP7q2H3RUG
X-Gm-Gg: Acq92OHvNL1n+Eas5imm4PZS8ExqG2bFQyP9F/VRcik4iipKbEjMxJU3nUW1nUS/66P
	fShxyBDh65ES45MUfzSDk3rsr/kJy2j/ebCQUjguBUY0UydMHa/SlmjBJgYNkaP1SrlULOFz45E
	sgYmmQ7ySNzqUcprZ7hpBa2p0fOs1DigZTaxrYWjk76La/Bd8yTESbS8Sb6nllbWccE+PdSbTS5
	PAxQbYJH6CN3lTJaHGNIXtM7JGxn5/iCqlcP9xrms5+QqNvKidk1vS3/14eU5cTxyKJxX1AcOhX
	ih4MHcLO/YJRx8AI1Hkg31OxWKBKgNrkiJ4crkK+/mEmhMfmeuDtdOGd4qhLf71QaXQk8dygol7
	KWwLh1PY3PUzsPU6ME5I4yj3AFDKm+3C4U+b0RZyCdhHLbgUHfFU4WBpFsHJAPluBMllUT1I6Db
	n0/3mfkwXdAH8wLbw=
X-Received: by 2002:a05:6000:184d:b0:43d:1bf6:927 with SMTP id ffacd0b85a97d-45eb369cf5cmr37265125f8f.14.1779892520738;
        Wed, 27 May 2026 07:35:20 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm6239763f8f.11.2026.05.27.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:35:20 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	jdelvare@suse.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/4] iio: flow: add Sensirion SLF3x liquid flow sensor driver
Date: Wed, 27 May 2026 16:35:01 +0200
Message-ID: <20260527143515.102794-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526173531.4422ae40@jic23-huawei>
References: <20260524205112.26638-1-wafgo01@gmail.com> <20260524205112.26638-4-wafgo01@gmail.com> <20260526173531.4422ae40@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 17:35:31 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Hopefully I haven't overlapped too much with the review Guenter did.

No overlap problem - replying to all the inline points below.

> > +	  Say yes here to build support for the Sensirion SLF3S family of
> > +	  digital liquid-flow sensors (SLF3S-0600F, SLF3S-4000B, ...).  
> 
> We try to have full listings of supported parts in the help text as it
> gets searched by folk looking for a driver. To minimize the churn consider
> a bulleted list with one per line.

Done in v2 - bulleted list with all currently supported parts
(SLF3S-0600F, SLF3S-1300F, SLF3S-4000B).

> > +#include <linux/unaligned.h>  
> The gap before this header and others in other drivers is an historical oddity ...
> No need to separate it.

Done in v2.

> > +static const struct slf3x_variant slf3x_variants[] = {
> > +	{ .sub_type = 0x03, .name = "slf3s-0600f",
> > +	  .scale_num = 1, .scale_den = 6000000 },
> > +	{ .sub_type = 0x05, .name = "slf3s-4000b",
> > +	  .scale_num = 1, .scale_den = 1666680000 },  
> 
> Maybe format this as one per line.

Done in v2.  One variant entry per line; the list grew by
SLF3S-1300F as Guenter asked.

> > +static int slf3x_write_cmd(struct i2c_client *client, const u8 *cmd)  
> 
> Might be good to use
> const u8 cmd[at_least 2])
> to let the compiler know the constraints.

Done in v2 - declared as `const u8 cmd[static 2]`.

> > +	for (i = 0; i < SLF3X_PRODUCT_ID_LEN; i += 3) {
> > +		if (slf3x_verify_crc(&buf[i])) {
> > +			dev_err(&client->dev,
> > +				"product-info CRC mismatch at byte %d\n", i);
> > +			return -EIO;  
> For all returns in stuff only called from probe() use dev_err_probe().

Done in v2.  All probe-path log+return pairs use dev_err_probe()
now; the remaining dev_err() calls are in the runtime read_raw
path.

> > +	for (i = 0; i < SLF3X_MEAS_LEN; i += 3) {  
> Fine to do
> 	for (unsigned int i = 0; i < ..

Done in v2.

> > +	*flow = (s16)get_unaligned_be16(&buf[0]);  
> 
> Prefer to make this a little more self documenting as
> 
> 	*flow = sign_extend32(get_unaligned_be16(&buf[0]), 15);

Done in v2 for both flow and temp.

> > +	ret = devm_regulator_get_enable_optional(dev, "vdd");  
> 
> No need to turn this on until we are somewhere nearer ready to chat
> to the device.  Normally we do it just before first access.
> I'd move it down a little. It's also not optional unless
> there is some other way of powering the device.
> Just let the regulator framework provide a stub regulator if it's not
> in the firmware description.

Done in v2.  Switched to devm_regulator_get_enable() and moved it
down so it runs just before the first I2C access (the product-info
read).

> > +	ret = slf3x_read_product_info(sf);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "product info read failed\n");  
> As in the other review thread, this shouldn't be an error a we want
> those fallback compatibles to work in future.

Done in v2.  Unknown sub-type is dev_dbg() now and falls back to
the variant from the DT compatible (or the of_device_id .data for
the generic fallback).  CRC/family mismatches stay real errors.

> > +	usleep_range(SLF3X_MEAS_DELAY_US, SLF3X_MEAS_DELAY_US + 1000);  
> 
> fsleep() for fuzzy sleeps like this - it applies a standard amount of 'slack' time
> and means we don't need to reason about whether that is a good value or not.

Done in v2.

> > +static const struct i2c_device_id slf3x_id[] = {
> > +	{ "slf3s" },  
> 
> Please use a named initializer here like you do for the of_device_id.
> Uwe is working on making sure all drivers do this and I just took a patch
> that updated most of the IIO ones to do so.

Done in v2 - `{ .name = "slf3s-0600f" }` etc.  The i2c id table
mirrors the of_device_id list, with .driver_data pointing at the
matching slf3s_variant.

Thanks,
Wadim
