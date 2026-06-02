Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16253D891C
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402963; cv=none; b=lLahNjtLS8EdAtr1zVhoBBiZHmg2mQUZLOxoU09pSxmVZtsfMjnzfk/cSSPUc/2dHL3+4+71654AjKXokOUPH/PQsqmMdCn9HBJy3lIoEKVLkdRajhY3aOp/xGhpiwPToZ4vdUMtas4NQ6Z3g7rorufn8GpN8WIsU1kTUoXcbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402963; c=relaxed/simple;
	bh=KUMtbd37dKGW7VFJni4oIu86+xQIgZrAuruSShZ+uag=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=D+E8EdphYmt5ZfWv1iHnWvaTfxe2ySlSyn0MLkU/n6xGe3ADums1njxRRaMCti1ZkasE0HzpWyVZQWYRfhz7hl61Si/QDOnKK6nOSKG2SndQnZrPMNt3+y254oSRUXLwHH+bAvmezxZmoJZws5CQAxJ8P+Mk/OesAyKCSBBwnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Np1827Bj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np1827Bj"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490a76757e5so19025065e9.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780402960; x=1781007760; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QSNb+iVRstZYqJOYyT+xflLdmOYKtCw1pPY1NcbZIU=;
        b=Np1827Bj81KUr/1+2wFvdo5f1sYWSjxV89S6oB5cvFvUkGWopSyi/O0Fzks5qGz4p+
         PAd3sZABuBQwhBP7HNnDdJILhYeyErPXtwKsblxXTNIWC0nNx/OZP2s3Xbv9xTjwDgJi
         nPnUf85F+gucnIL31IeAcsRAoaklDJj0ypfPhZWVg1qFgoJT5/NPQrYDDOmyKWjh2zS6
         K8jpAZUlgtgPYQTB1jNYrlsNxtA6aa9U6kqClyqBTFb7lJM1OANUbbRi5+zFf1Q096YC
         16Dalpo2ocL7Vxhm3+GyfD4IVe2tR7dwTNIJGtFArLMhIDgfzH8eAaPsUbL04YzIRpIA
         DKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780402960; x=1781007760;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QSNb+iVRstZYqJOYyT+xflLdmOYKtCw1pPY1NcbZIU=;
        b=QCy74pZTiphcsgei15V0dQPxx6gvrWnXB3Che3QEWGjYS82w3WaME6dFXz7q/WRJyp
         rprrbNlujDqHQlWdLr/jACmk073lp0SJVF63jEOMGW+Oha8PIid5AbpJS5FebJTnnXQm
         pbisG1kRjCf1LUbZBP7vPr9BwfNkrprqlkYgNEcla3rJVUVpyY+5LKh/1YcZra+ZiZZQ
         aUQH0W4U+JVtvWzY9E4HaVUZluVd5FdavrmIvNZiEp6jJ732FsMg9wvZ29Fie5AgcEv5
         NToSv/rwgIEesXQEoNrKv72A5eUoY2tOPOtbZ+aS+9iEXQHG5h1qJpYyoeuPyQ8hMmCz
         X8lw==
X-Forwarded-Encrypted: i=1; AFNElJ/C10OkgFaJDWzZGF5rKpHqZL3G7bH+kFkutEF313u6U5N/PDP6/evXWFdjA/+XdvuWpTGs7gV7hJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnAHdj2MeH90bzWXe7QzLf+tBSaxWEQ00h9tcfmtd9FJlYMIGH
	7nNy2L9ls0QX7jkJu5ixPKeDITjIvi7mn9Aqasu9esINio3tXmWAIcmv
X-Gm-Gg: Acq92OE97biDOm15gcky8IZJ8kkZDoJ/Atv8ackJ/xEhJoM3LgyOvAZOUDctbGYI1Kp
	KJ2Mk9hSGEGLsfx/CV9Q63MFwtqLaTkEwoCyAJwBGJpxXCUH86YmEMQanKVRJi8YZ+DQ8nhRL2P
	t228nCExOgXh7EtEUEHGQRTfMMe2T+UMxJ6f8SYWfh/O7GOkMsjXSgcFCorQTgujRk5o+/uoDjN
	4h/yXi0xK+WE90GYbW2UZryQV0FBQabsz3pJYw+bxJu3lcmdnFL1jcUt1NIPEsy4lHKCBn7gvEa
	ZWICZDV9IJKl9tOYA4pYc2bHXF4Qf6TBZRd8iisrutq2wi9gbe2Hd+stIujdcQyi+4ISIK2UpZz
	cFzHv1Pdas+h3ZlYwUh/ZX/W89r8k80nB7QJTJpW+MO3yOWAVleoMHPIhVwYdmRuSrXSV/BD/em
	rY/SvGs6xMPcZJJnq2ymdx3tOCv10BEfR3+a6wljL9pG1TUyQ=
X-Received: by 2002:a05:600c:1c0a:b0:490:846d:e2de with SMTP id 5b1f17b1804b1-490a293fcfcmr291135115e9.28.1780402959943;
        Tue, 02 Jun 2026 05:22:39 -0700 (PDT)
Received: from localhost ([2001:4bb8:152:df59:3b69:56ea:a39b:adb4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490aab4f87esm39386465e9.22.2026.06.02.05.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 05:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 14:22:36 +0200
Message-Id: <DIYK6APQQX6S.2KLGTD0G5GCDA@gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS
 series
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Rishi Gupta" <gupt21@gmail.com>, "David
 Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Matti
 Vaittinen" <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
 <ah6p-f2RCW8VcuDR@ashevche-desk.local>
 <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com>
 <ah66ljSiIc0ywFC2@ashevche-desk.local>
 <CALoEA-wdakU-Ei2FE3WpGR+CYRDN1bjv2sZ=XJ01ZeH3NP8xeA@mail.gmail.com>
 <DIYJ5ZACTWVS.13T8L275VHTKM@gmail.com>
 <CALoEA-w3TqD=2YP36=ScmRttmmG3BBCKvtfSqeJL0PVxRxEbuQ@mail.gmail.com>
In-Reply-To: <CALoEA-w3TqD=2YP36=ScmRttmmG3BBCKvtfSqeJL0PVxRxEbuQ@mail.gmail.com>

On Tue Jun 2, 2026 at 1:47 PM CEST, Joshua Crofts wrote:
> On Tue, 2 Jun 2026 at 13:35, Javier Carrasco
> <javier.carrasco.cruz@gmail.com> wrote:
>> Thank you, Joshua. One question, though: maybe you remember that your
>> last driver was missing one header (which I am not criticizing at all,
>> as you can see I missed some too!), and I am wondering if it was because
>> iwyu missed it and if so, how that could be avoided.
>
> About that - I didn't actually run iwyu on my driver, I recently migrated=
 to
> Fedora and forgot to set up LLVM and iywu-tool :-)

I installed IWYU and added your mapping for a quick test, and it wants
to add a million headers or so:

python3 ~/iwyu/include-what-you-use/iwyu_tool.py \
    -p . \
    drivers/iio/light/veml6031x00.c \
    -- \
    -Xiwyu --no_default_mappings \
    -Xiwyu --mapping_file=3Dtools/iio/iio.imp

drivers/iio/light/veml6031x00.c should add these lines:
#include <asm/byteorder.h>                     // for le16_to_cpu, cpu_to_l=
e16
#include <linux/bitops.h>                      // for BIT, const_test_bit
#include <linux/device.h>                      // for dev_get_drvdata, devi=
c...
#include <linux/errno.h>                       // for EINVAL, EBUSY, ENOMEM
#include <linux/limits.h>                      // for U16_MAX
#include <linux/pm.h>                          // for pm_ptr
#include <linux/stddef.h>                      // for NULL, true
#include <linux/sysfs.h>                       // for attribute_group
#include <linux/types.h>                       // for __le16, bool, aligned=
_s64
#include "asm-generic/bitops/builtin-ffs.h"    // for ffs
#include "asm-generic/bitops/const_hweight.h"  // for hweight8
#include "linux/array_size.h"                  // for ARRAY_SIZE
#include "linux/cleanup.h"                     // for guard, scoped_guard
#include "linux/compiler-context-analysis.h"   // for __must_hold
#include "linux/delay.h"                       // for fsleep
#include "linux/dev_printk.h"                  // for dev_err_probe, dev_db=
g
#include "linux/device/devres.h"               // for devm_add_action_or_re=
set
#include "linux/err.h"                         // for IS_ERR, PTR_ERR
#include "linux/iio/buffer.h"                  // for iio_push_to_buffers_w=
i...
#include "linux/irqreturn.h"                   // for irqreturn, irqreturn_=
t
#include "linux/kconfig.h"                     // for __ARG_PLACEHOLDER_1
#include "linux/regulator/consumer.h"          // for devm_regulator_get_en=
able

drivers/iio/light/veml6031x00.c should remove these lines:
- #include <linux/bits.h>  // lines 9-9
- #include <linux/units.h>  // lines 17-17

The full include-list for drivers/iio/light/veml6031x00.c:
#include <asm/byteorder.h>                     // for le16_to_cpu, cpu_to_l=
e16
#include <linux/bitfield.h>                    // for FIELD_PREP
#include <linux/bitops.h>                      // for BIT, const_test_bit
#include <linux/device.h>                      // for dev_get_drvdata, devi=
c...
#include <linux/errno.h>                       // for EINVAL, EBUSY, ENOMEM
#include <linux/i2c.h>                         // for i2c_client, i2c_get_m=
a...
#include <linux/iio/events.h>                  // for IIO_UNMOD_EVENT_CODE
#include <linux/iio/iio-gts-helper.h>          // for GAIN_SCALE_ITIME_US
#include <linux/iio/iio.h>                     // for iio_chan_info_enum
#include <linux/iio/sysfs.h>                   // for iio_const_attr, IIO_C=
O...
#include <linux/iio/trigger.h>                 // for devm_iio_trigger_regi=
ster
#include <linux/iio/trigger_consumer.h>        // for iio_poll_func, iio_tr=
i...
#include <linux/iio/triggered_buffer.h>        // for devm_iio_triggered_bu=
f...
#include <linux/interrupt.h>                   // for devm_request_threaded=
_irq
#include <linux/limits.h>                      // for U16_MAX
#include <linux/mod_devicetable.h>             // for kernel_ulong_t, i2c_d=
e...
#include <linux/module.h>                      // for MODULE_DEVICE_TABLE
#include <linux/mutex.h>                       // for class_mutex_construct=
or
#include <linux/pm.h>                          // for pm_ptr
#include <linux/pm_runtime.h>                  // for pm_runtime_put_autosu=
s...
#include <linux/regmap.h>                      // for regmap_field_write
#include <linux/stddef.h>                      // for NULL, true
#include <linux/sysfs.h>                       // for attribute_group
#include <linux/types.h>                       // for __le16, bool, aligned=
_s64
#include "asm-generic/bitops/builtin-ffs.h"    // for ffs
#include "asm-generic/bitops/const_hweight.h"  // for hweight8
#include "linux/array_size.h"                  // for ARRAY_SIZE
#include "linux/cleanup.h"                     // for guard, scoped_guard
#include "linux/compiler-context-analysis.h"   // for __must_hold
#include "linux/delay.h"                       // for fsleep
#include "linux/dev_printk.h"                  // for dev_err_probe, dev_db=
g
#include "linux/device/devres.h"               // for devm_add_action_or_re=
set
#include "linux/err.h"                         // for IS_ERR, PTR_ERR
#include "linux/iio/buffer.h"                  // for iio_push_to_buffers_w=
i...
#include "linux/irqreturn.h"                   // for irqreturn, irqreturn_=
t
#include "linux/kconfig.h"                     // for __ARG_PLACEHOLDER_1
#include "linux/regulator/consumer.h"          // for devm_regulator_get_en=
able
---

If that is correct, I bet there is almost no driver prior to IWYU that
has all the headers :D
