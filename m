Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5403BB69D
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325033; cv=pass; b=M0eRLkDVyW9kfb/8ysHybBrL51ozQphTRQNQ20jsljRlZamrEIwJOi96wl4Hk35bZScHBluqI9JF/jazu33AqUW/4jGvgUfruazGvWWXEO6FkZvOL5D1I3OCM5NQs2OrFf3ughxwRBlTUdxgmNsSxucfw9U65xo8H+uxWTw71QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325033; c=relaxed/simple;
	bh=SjbsHlFy9x0kgDl+4/irECvQxHpJEXXlnDbBP4VzqKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOlUBmwfghDXcxICYHv8qa0jTb9skZNLB5f8XxrBjpQuw9ElOQYG8rlaE3w1cWZ+j52Vi9MmhXv/5RdjwbFQmsxGHZTNpHUGr+VQS7+YUGNnqtHkFqnQ7+yXwC9KIw480Q/atpYppLxZeuLNabwkPa3aafDPpoJeW0pspr9rRDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd0yk7CX; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd0yk7CX"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso93161955e9.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 07:43:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325031; cv=none;
        d=google.com; s=arc-20240605;
        b=htNXWTqPFm91r5yZNrRkun8J+sBn+SPqR/Uedo4+yc342idv3fVSjWkUutfwQxpR4M
         nCyx+uF1fFXUY+fyaBU1FDgqK4WF9DfqdOGdcXR2UmvZ2xM5qOiTthW0IbNgMYwajx1+
         +GNDsADYuuDlZyYNTZuSqNceyVMzG/mDkqgFvSBkIO8D4r0Liot1XlVHvoI012jUTQi9
         cbjhxKxcbS4TqFzwYHIGGEogAw/0ztSUEJcdkTk0LO4yPK6ZPT5MiW2c6PbgHTIndQfZ
         N1RrG43pUz48ogpcQeLj0n/HQmFz60Yf83aLWl9qDmnrQqAlHNzit738M+G2W2ArnCbM
         XdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FaJ3M/Cax1Tl8C/6XQMVNUNdMZtIFF89XnpPr7Qd2Vk=;
        fh=vIrN9Cu5CHMtSkVnPSxPnzTWMysU3A1910mz3C0n09w=;
        b=j+o3kXsKZAP+d3WHI/G9G64ySgyFh6SM6eCHo4uROwge/KD00G/WewICIs2IFaPgJ6
         5CPQ44zn4kN/l9+n3LBMSjbRFJlPkT0qsAIjj3hMYrN1matAWxQsz+sxf1n13tO2udNO
         CbH7ZKGTTTMSkWZU3HJ3fla3+x9W0FGrhcfdFJAa33/FLd1G4sZk6EQgSjeRWaIgO9Ab
         o/kiiumP1rJ/E2oW7zr7/+pq6+K48rOZ67lQIv68U1gse+fHPpKmiXYYpF+fVN4loljr
         jJx25EHhKIItdPJ6G4knHMHaCYFF01Hn14rRQ8ea6xD8xJ0Pj+zTZyxGh8lvBeltIEeK
         0deQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780325031; x=1780929831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FaJ3M/Cax1Tl8C/6XQMVNUNdMZtIFF89XnpPr7Qd2Vk=;
        b=Nd0yk7CXMkSnlXp99V5xmUSkaCfg37tSayX45ze7MuDWiBsLVzshKoH2fJ/GV59540
         ZY3BORToO9cgRUSbqtyMcmd5c79G0X4RME8YnHQz52YF5QxmRtfeekfp8Wq07u3unUHn
         Ec0FN/+Z2uN1tlpiKJweo0xzpLTZV9ZEwiDJmCCLg//4GLWuXB4mCylydEBUKLx/eC+Q
         ejfE41y5oPFa/QPTTEn6A9nn6uafZAB8yyUC8hi4EFEG2vewQmWI4FZcWpRrYNYmjAg+
         ipUvfJVexkdC234JQfKrb6TwxyV8+zlx8O9m325y4loXUb5i1xjjtOJrnl2p+80NHVph
         yKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780325031; x=1780929831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaJ3M/Cax1Tl8C/6XQMVNUNdMZtIFF89XnpPr7Qd2Vk=;
        b=n0jOZtqPe8ylPFB8cO70JcEBLoBNxRz0+iv8LCaM/oP3K5nuPUr+5zCrdTgQAjSyTR
         JdKciiXmQQyb5GrR1MteceHWHcXtWsm5mfhXc+KF6bEMSB4HmACNTTj3AFSgO5YnCvKj
         0wli19hgywAEcLIJmYa+TKUXsi+tQufby5NcbMOaMr41Y5sq+dgX8VTsdNbIVYn+dnrP
         Ypu/f8gB86FGDODb1FwQRqKYh9maItNbav/lr8cBXKpnElYfYVFQ5x/1dUB3Zg9OP5tr
         jXO2LkA/6WPKXffzbuDk19mtUhODS9X7V/enPT2cGQqj2EHSHW5m8KoDHrq/DtSnfwGc
         VXYw==
X-Forwarded-Encrypted: i=1; AFNElJ8sFP0KAHnysR1zybRYFGoTDQlvL3SHbo8RiDb+4uOu6eJvdlHYMngLIu7x0fOJ4wQ6f4LPTcS5UQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Q+ykwjUqaV+O2PA+/3BGC5KaqQTvJyTjBxULPUmHoLFz9VyS
	DNR6UkZ5s/vI36dgnqKGOsPJwxfhs5R7ehhxahTub/md5Ld7RfuT+QBB3i9IEJxpbhAwIFA31Vb
	WOVwhrfDeae32OFV+s+0nAn5jX/FaE7g=
X-Gm-Gg: Acq92OHL3xqbF3kSZwcUw0DaqI8Nb8KEGwoTCs1NAp93bjmdGNYsOP20ut0Rfsa2zrr
	IUC3pZplySxyw3F0QNv0km7QC9C0MBAnfoR84sqT8/yjuaFr0TpubMQ35opM0IXeWPn2QFzZHOQ
	YBxmoAkEOGQ3KPfm67kWJngge+wupfIbdwnZBVAIZnNIWYdHb7pub9Gh4h90vRQoaGmfLBWyXRF
	PFmRku3IMP5d0v1VSL4baK6pVhwMhkbv5/RQJ8yeV78GcxJZhPrXWyq5NMvRb9lt7Xu//aM8MPj
	W0Pki4yp44/hKHbVg+6b3yp5ym63qN8M4AGr++KQqEXRccb/WI1yBborUDTeZq/rDJBjG2+e/fa
	qMc9kZqrbNFCS2eSQXis6mwHKQJDHJrcsSOezJrv2YNN6WZU837LieirGCjAIRF9sxzjCtdpYPQ
	/FN5FA+QuLGZCYxrKa
X-Received: by 2002:a05:600c:c3ce:20b0:48f:e230:2a21 with SMTP id
 5b1f17b1804b1-490a2975173mr158041835e9.32.1780325030803; Mon, 01 Jun 2026
 07:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com>
 <20260530-veml3328-v3-2-dd562eaee8d9@gmail.com> <20260531101940.037d1d7a@jic23-huawei>
 <CALoEA-yEA5KcvXqZCCg76qFAgyNq8BQ5+gop442mju-9PiKaxg@mail.gmail.com> <20260601101726.203f56cd@jic23-huawei>
In-Reply-To: <20260601101726.203f56cd@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 1 Jun 2026 16:43:39 +0200
X-Gm-Features: AVHnY4Jx9jpFwIQ3QFkofnO6yXaTKK95j63cGKSeFtD73y_KSpdW0rK083otLxo
Message-ID: <CALoEA-w8zX+bzpEfvGoafDaOr6Kd-USgsyZ6SRpV08Yw6MaVrg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: veml3328: add support for new device
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 at 11:17, Jonathan Cameron <jic23@kernel.org> wrote:
>
> If you have time to figure out the path that causes that, it would be excellent
> to have it recorded. I spent a few minutes the other day on this and couldn't
> find it.  Maybe ask AI to figure it out :)

Maybe, just maybe if I'm not lazy enough to do it :)

-- 
Kind regards

CJD
