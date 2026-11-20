Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795139786;
	b=Qw+Q7VeaWQS87wlI/TqkiNpAuvpYpNG+tPbNRnIQj/46pzephHJFiqCbP2DzPBi3TdHm
	 vFmAMzmcZUUpAsKrrchQkiL/ufHeSaN+M/8wJOXdyc1Givbchne2f2z2CN9CourF+Zowc
	 OSmUMKDnd7Xo3biOutJ+jOcV1yBc2ubaMP+bHbyN15UxG8X5tvz703oSjsLV8j2weYqHc
	 5oD1gDb5yqXgfUC8LeTS03PBStB7G1pVhSRy726XOMx2cLKkymxQHN8AKrAebB+foCTWW
	 H9BzqjjWVpU74uaUZxO6JakboSgEzA+/uR32+RPKuy82CxOFF9Pv8Tg/0epr8cPAu0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795139786;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=urjf4AC9bsXTT1eVHNT4ykrZDVSTa7nIdMT+3Gi89aQ=;
	b=Lpvq8krex2PR1CiiwNOOAKMK4Yz6GVZPbVlsejuu2hM6MMHhp3JaqBt3hdiuqMA+6Fnj
	 NmUK/sZtlRytzjTM14HbEZbDYcazLjZuxsxtfdf8exfm8LAabnZGQST6cHTX7KbBUOsTk
	 gU9hWCwwEFq1tX37KsOLUq66cehkZb/cb1d+VB2vAkDmwfySoeufh6h7f7rCjyJn7VtZy
	 mZrdb8TBbnSkzxX6yVu1/obwdykYOZu8G3UtKMXzEkF8v3DBhnp8nb2uhBbFUkM67J/gl
	 7fUw6mv8M+FSWHamlGcAQGXF7KwUWgblgTzCOqVYfg45dwEBXwp2oSJ4/UdlwjM06GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=BeNVnr0t;
	arc=none smtp.remote-ip=54.207.19.206
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C94606A33E;
	Fri, 20 Nov 2026 01:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C94606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=BeNVnr0t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795139747;
	bh=urjf4AC9bsXTT1eVHNT4ykrZDVSTa7nIdMT+3Gi89aQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=BeNVnr0tKaqzlH/n4RVds2yLjDE/mEkUFuzqWcbpw8UvrclVNbq8QSyBSqeIGRhrn
	 YIXDD8va97B36uAQlxoYMiZ7bQgMjHSGYhTktIUF26KtAfzEnA5FNDpmy9PXVLUfeO
	 efwFTv7bfbHaH4Xm4g5DnmM0zRx+ZoGHrHdnKEnA=
X-QQ-mid: esmtpsz19t1795139744t04e5e70e
X-QQ-Originating-IP: lueVd0uYLSUaRc0J61bYcEjliFKuQPK4iPGscDgXEgw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Nov 2026 09:55:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10927731245451487187
From: Siqi Chen <chensiqi@uniontech.com>
To: crofts@kernel.org
Cc: jagathjog1996@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi323: check i2c_transfer() return value
Date: Fri, 20 Nov 2026 09:55:02 +0800
Message-Id: <20261120015502.4059368-1-chensiqi@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cc270a65-985a-45ad-bfdf-b205cf9ff86b@kernel.org>
References: <20261119070837.3844364-1-chensiqi@uniontech.com> <cc270a65-985a-45ad-bfdf-b205cf9ff86b@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mdc3TkmnJyI/nOkjmVVRQel8NzXws6X/V4G043ATJHv3j/YDFC8qHhLf
	n44+z2kUsxLZToD3Wg2JXIK9jRuvQukua5d1CNCl3Vbh/PpvRlQE0bosWuWEaDBllW6vsOI
	q0E1hVWvps3WIbLaMLW8FEP1yWCadIQjFJggP+ujncticxfEfd7X4KpSwJ6yI/owQRB6AhF
	IU8CHV+/eHG9JR+gj2svFnPwgYZeihFEcvzISUTl32xVinVkUv5k31NSDqeQeGO7N0+lKCR
	az6wkIyrZZhvv2arTEL/HOpcW0nLALA7ytnXHVFvtanUF+J83KS4uffXGQlO+5p0vX6u1J0
	TPQrAjJfrSzntcNI8GRaES7d44eK/Fo/Vd5dXMZYzNch2G/oQ3YlO2O6iCgUdyVto+6aF6k
	LVxT6FUZpB7vR4gWxLrj8TJAk0C8ipw2trID+WN8pHKENdLmlcl5yuwh2O2Mnl5l2nZ57gV
	QivLtLet16UBZIOCVDaxZnLw17ZDqDLJe+kj/4KNOTkTVTRMV+Vco8qP/Ej2unG88+aaHS5
	3bnu2kRmY8Jz2LpSo9B4tue+T8o2RsPvJ7cy1ic6ICnKWbQKUnkkq+Nx5wy4DEebYiJGKP9
	JRZSmib/pJxKDGp4+JaDoGbhbIJ7SYmgV6TgEbQuebTxM3MorLg9Dceido5OhLTmE9jKT3J
	p6UnLtSAP0qfeAaz4nmgySRpv/yHylLuHJbI2Y3/UfH+NNAbd8U1ou39/z9jGueUATi0yqI
	qIxUy9FfwFqgUq9aOzLVd9Ru12iKTbbrHL2iP/kPNkjdBT9FfTNmsE1BZLO0ND8GXcHAwU0
	b34PPbPBltk29U5/DoCIkWof18X5wB1jsv6phi1M7PvgIZ8ek8N6Kap946136ZbSwSBSor7
	8XEVhB5y72l8KcaaUq3PZK1pei1zkiJhcjgN4o0H/lvYJ6n328ENaaUJaUZBxCghfjgmYtO
	vkc84jBo301AWjxEHuQ0vKJuJgJeWE19vdFzp+3F3xm+6RMrFEJM9IDlWdVc/zn0edZZU/Y
	kITgrikQeR+8RuDBGNj0lUNb8rTy/qPL81T5lDuTUfowhqGdN9
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

On 19-Nov-26 10:30, Joshua Crofts wrote:
> Also the testing info should go under the ---, as it's compile tested only.

Thanks for the review. I agree that separate checks are clearer. I will
also move the testing information below the separator and send a v2.

Best regards,
Siqi
