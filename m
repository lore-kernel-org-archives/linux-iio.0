Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793927212;
	b=qWtw4VapIVGnj0M+vCR8WmfRrDC6hOxzt3X6/PKS3h16XgxEHwasXsMF1CXoUkFURI8F
	 FGXoIotAmPpOcQBMzzfzTTnNW0GFHKLU8/zYA9Q5SoEzQV0JwYOJG/GPDEtXaHAoZL8Ae
	 FzwI3Nh7PLt8U1f47Gy9QnoTu3Ktz4VyJdSk7HpJ3XFb/ntweII3dLt1Ecd3sqKxj0WR2
	 Pj5S/G9J8XKqkp13GZ0olcLHBqUeUWXaDQN38xQ0yqsHoUgTQaKvSjH2h6JrbDZ+5y7bu
	 QKSWHKk5VkrlLftbXeczxSITSvVxm3zcut/lisEGPiX7jcpZgyopKtMrS/7m/OpcxZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sli5Tik7wgGinR9EmKOShOO8llB8BZYKVbdNtNJa+KU=;
	b=qZZXHTPfnMObguvOf3lnqL6uVJby7DlbLdq3AvslW2oPpMSSHatZTc78rZ5p9ovfSaow
	 QfEdux8wTTPUdZ5jiHqAotlYJX6nyIlzzzphhYyLLOEri1hdzrgF9ghc4pmCW1lwU/5yz
	 LhsIeHPdnyODFDgfw/kg3r0zFzgkfvLug5+XatJB/KIICQOFkNIpwS8MjloTY1KP3F0Rr
	 DHXIBzIBPGQZSHAsPTb/43LHfrx4N3U0ZLoL2qjes0QquFIqgBlC5YCfWnB4hbA6Or1XV
	 EpBw6bt8J09Nq+/DY1I854jT8ya4HBJf7hN45yef3N611/y1Ynyc5nLi11dQuQM3TnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TqAPnM8e;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12D606A328
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 01:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F12D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TqAPnM8e
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so218525c88.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 17:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793927211; x=1794532011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sli5Tik7wgGinR9EmKOShOO8llB8BZYKVbdNtNJa+KU=;
        b=TqAPnM8eT4V3Yp6wyLQNwAKn2r2fSx7tX0Zqk/qc7IB8izI5Uozb/tMECIjjGEafiz
         1XFCiZQ2hOtqvr4d7yuPXl9kI9njiF+tW6Yk9lkVnHl3M4XW0XVZfynrDFsevN4wVOYK
         wwdDhHPiqM9KD8T7mdEkr/p+auuAZnNazL/nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793927211; x=1794532011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sli5Tik7wgGinR9EmKOShOO8llB8BZYKVbdNtNJa+KU=;
        b=Ns4ptJSomr1VoZlSwldWavOaENxof0jcPt88bjNrldxWOF52NcPSe1kGyji6Vtlv0K
         IQljtAo19+w/1w62GTY9A8Urc5fL9JlBjWovrUgVwVRFZ08VMr/QkGRtPNqNjtBGGkUD
         3N2bMJHc0x4YyFBlU6jma5+1Q9cniinIDTc3rnus/jq2bnQ9nAFHfjPISrAMLrghNcSX
         FMHwFYKZqgu/TgtHm1itgHc+Mce5WnIm41jzg+0op3grq8gU38sFE7hCdAiYnkwZ49KC
         TY8NNeinFzzY05A1FQmKM9f7LQiR52pAmhh1FIjKsMIhj+f5iS6ILGPuk0r+KfsS9LHP
         N8qA==
X-Forwarded-Encrypted: i=1; AKwUvBwTSuhg6Yk6HRZAqNueXG0XqGIDiBnwx3usNrYhCCiwsYTBwG3LnzXG2CDc2OaUBcxhpeUV3eAI56Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qSgyJ4+4ewdDVYcGhhGSXlqFxcwvNzF2anFT9Wjk01RB/vwyc
	x85vsV9Bq8B3WQbLhdXWxMD5zEX6Pj/Y7uJM/GSsisCV/4nrRV9rN+OL2ZaunH8aww==
X-Gm-Gg: AYBFou1FL4vMMdpv+EYE79C/5Cz418Swv08jrJxtMHjkNxBjKYuo5Rg1EPLiXONn762
	E60pzk2Z5W46IJtoKOdVnhS5xAbYL9COUQjmYg8Fyz8V1BO7uzCJCYuE04rcQf20/HsnSpwb3NU
	03isg/NEurGnROSfCmJs/YniFqIL0PWd+om7uznJggK7oiX39YdHI0F2x4+FLH8fV9Do8EMIHhS
	4JK1obmpBzL9nDlecLP6ZExnOHfDowmlzMatqRcqSzOV+wqW6gIa8fp/5y77XjAZNcHLFQ3xotc
	Bh+B2c0eHjKnJ7YrMhB2WNd/R6MdM0zKTA0LYQyZPdoQTd4j/+3e2ACnE5D+nka45Adb7TewFK2
	bVnd9Bkh2OPG4CvsgojfWk2INiCVWPYm9N75D2K+FUxGrzlWnwd3HMAzDDmMdzxDGeEMh6pEedU
	qLo7A60omGeXaoqo59K3PF/0I58Yht8Bk0ak2V0+elHhsYcolt2/407dgfw8UyKTrsavAGhBeK+
	yuWvFsUwDnmQ4JH401NSpLBuKWDg0Wz/r28Mqa72u7OE9hy3ktvm36xCiKVZ8h8pm0fdV3u7f4P
	eS7BbbHmICKQcK6K/1pdzlyL4PeUxDK7LzpKwePR/+1IbvP1JIS5Qc2UoZ32kR75C8Q=
X-Received: by 2002:a05:701b:4246:20b0:1b2:558a:d769 with SMTP id a92af1059eb24-1b25d28c272mr1042791c88.4.1793927211233;
        Thu, 05 Nov 2026 17:06:51 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:bb6d:e00d:d359:7933])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b25e407bb5sm828381c88.1.2026.11.05.17.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 17:06:50 -0800 (PST)
Date: Thu, 5 Nov 2026 17:06:48 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 3/5] PM: runtime: Propagate last_busy from dependent
 to dependency
Message-ID: <au0oKFb9CmNzc6Cg@google.com>
References: <20261103221717.3840215-1-briannorris@chromium.org>
 <20261103141442.v2.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <CAJZ5v0jWCz0XDgzeETbmMfGOmvh2G9qcx7xLODrpQ9NiwsddKA@mail.gmail.com>
 <auuICAm4BC_8Pzs5@google.com>
 <CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com>
 <auzlLwlleGLPsLcw@google.com>
 <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
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
In-Reply-To: <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>

On Thu, Nov 05, 2026 at 10:18:52PM +0100, Rafael J. Wysocki (Intel) wrote:
> Of course, it will not prevent the parent from suspending if the child
> does not attempt to resume it for a time longer than its autosuspend
> delay.  That's by design and you didn't have to take the time to
> demonstrate it.

To be clear, I wasn't just trying to demonstrate for fun or because it
wasn't clear. I think there's value in putting concrete reproducible
test cases out there. (KUnit is an easier common ground than some
particular piece of obscure hardware.)

> The question is how often those kinds of patterns occur in practice.
> Or IOW, whether or not they occur often enough to justify adding
> complexity related specifically to addressing them.

Well, I tried to keep very close to the spirit of the actual real
reports in question. So when commit c537d3457542 says, "As an example
[...] cat in_voltageY_raw at a 0.2s rate", I think it's not a far
stretch to test 0.1s too. And it's actually quite odd (IMO) if 0.2s
behaves *better* than 0.1s or 0.09s, just because it hits the parent's
rpm_resume() more often.

> > On Thu, Nov 05, 2026 at 12:59:24PM +0100, Rafael J. Wysocki (Intel) wrote:
> > I would love to hear your counterarguments.
> 
> OK, I'll say more about that tomorrow (it's past 10 PM here, time to
> go away from the keyboard).

Great! And don't rush on my account. I'm interested in eventual
progress, even if not rapid. I'm sure you're busy.

Or, maybe I should have gone to LPC...

> > I don't believe your solution solves the problem,
> 
> That depends on what problem in particular you mean.
> 
> It addresses an inconsistency in rpm_resume() and as I said above,
> this needs to be done anyway because it is not only related to the
> cases when children or consumers are involved.  There are other cases
> in which rpm_resume() gets called for an active device and the lack of
> last_busy update causes the device to suspend earlier than expected.

Yes, on second thought, I agree that your patch addresses a real
problem, even if it's not (IMO) quite a full solution for commit
c537d3457542's.

> > and my solution does while also handling
> > the inconsistency you mention.
> 
> I'm not sure about that.

Sorry, I see that part was inaccurate.

> For example, say a device has an autosuspend delay of 2 s.  Say it is
> initially suspended and user space writes "on" to its "power/control",
> so the device resumes.  Now, 1 s later, user space writes "auto" to
> the device's "power/control" and the autosuspend delay is respected,
> so the device doesn't suspend.  Next, 1.5 s after the first resume,
> user space writes "on" to the device's "power/control" and the device
> does not resume because it is active (its last_busy is not updated).
> Finally, user space writes "auto" to the device's "power/control", say
> 1 s later, and the device suspends even though it can be expected to
> stay active for at least 1 s more.
> 
> How is that going to be addressed by propagating last_busy from
> children/consumers to parents/suppliers?

Agreed, your patch addresses some scenarios mine doesn't.

I also agree the power/control behavior is a bit awkward, although it's
not very convincing to me as a use case. (Arbitrary/periodic fiddling
with power/control seems more like a nuisance API than a real expected
use case.) Or if it were, I would suggest solving that by adding
pm_runtime_mark_last_busy() to pm_runtime_allow() :)

To me, a more convincing one is: a non-autosuspending child with an
autosuspending parent, in a situation otherwise similar to commit
c537d3457542. The child is not likely to intentionally update last_busy,
but only implicitly via rpm_resume(). When you solve the inconsistency
with your patch, then it enables my patch to be more effective w.r.t.
the parent.

> Note that I'm not dismissing your proposal, I'm just having doubts
> about the need to do this kind of thing in the core code.

OK. I agree it adds a bit of complexity, but at the moment, it seems to
me like the most thorough way to improve the ergonomics for clients
(drivers) here. And that's pretty much my entire motivation here: to
improve the ergonomics of runtime PM -- even if in this case, it
requires a little (core) complexity.

So, I'd love to hear what can make the ergonomics better here, with less
core complexity.

Thanks,
Brian
