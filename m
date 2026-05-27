Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1503D522B;
	Wed, 27 May 2026 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869919; cv=none; b=j4fq1CXx8YFEGLGqlTTbqB7328uDyvMJow2whiEAu0TewznAyjNeeSa/+QCqJV9ovwIu7IY2M7P7Uw3dH7f4FSImVr9fU24qROB2MtPz5IH70l0ZzZsJEC3jLcEsT6ZAMUsigpenPrX15n/4TT3EeMBGVLUs7N4A8vCUZqobMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869919; c=relaxed/simple;
	bh=Q26JtbQtPlwJVVZhN5bnyKRHUhgKb7hYUJpP/5dlAxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTI/WS9rpQs1ABMddD4hHZQTFxSbFA7YsdiHn69RjTCRjhqWzhbTzCJM6+427nmo3apDL/LZLxeytpiFf2H89IW0a53A+7pLK75GSMYmTM1Z5LfISgojMGgP6ydMei3oxOYaS8tofmsXHnP98nISgJ1x1+1cPoShXEXok4TVak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYTPusOR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYTPusOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4741F00A3C;
	Wed, 27 May 2026 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779869917;
	bh=YM2j88JeD5P4CfthV70rBpTdq9wsJHbxRbHH2tFsGog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cYTPusORGzgOQH5PI3xqD2Xg/owSBBoAPHtq4w+8HLTKy3XhYTfOPQMK//yKQOB1b
	 2HUsEcUPZv2uBWfPMb26CWfWsN/xNXNI8gGYdenR2Odb/tQId4U3oZW+BxmIPkJvQm
	 cJjf3IzHBirGjNEpztKWE87rdyVVMAo+PvsWc5KCKmBL7H1UZaOWMnVwe3gVnIdSHr
	 OjXiu5S3YafnAlu0vYLftP9yhjiyzpUhinILrE7xOBOf19MNhNnNphU1A4iz6ddhSS
	 Fc8crLqcJWD0BVy8gIiUcXDesx5TodmhOtW4MVibA/dvTP8tbTF8ZCiQzwVQcbl9MZ
	 Xhwxl3ht6A4Eg==
From: William Breathitt Gray <wbg@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	m32285159@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: ti-eqep: balance pm_runtime on devm_clk_get_enabled() failure
Date: Wed, 27 May 2026 17:18:29 +0900
Message-ID: <20260527081833.505655-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAHp75VecaMW5S+jtP5ZMr2ZtPTHXsTeVzos7+WSpgnj7YcMjLg@mail.gmail.com>
References: <CAHp75VecaMW5S+jtP5ZMr2ZtPTHXsTeVzos7+WSpgnj7YcMjLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=wbg@kernel.org; h=from:subject; bh=Q26JtbQtPlwJVVZhN5bnyKRHUhgKb7hYUJpP/5dlAxQ=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFliK/YeKZll8r6gQWrDqkOdXnEekeIzv7zrZt086zvzr XWnvnUbdZSyMIhxMciKKbL0mp+9++CSqsaPF/O3wcxhZQIZwsDFKQATYXnE8Fc0UHthQVFGf8eT te6xWyRO8+2alfGo8kPP6+s2s/jSWdcz/FNpVPdIep56SMvs2aIoVg5fN/ZpuyvOfJEQn9FW4FL syAYA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, May 27, 2026 at 10:10:20AM +0200, Andy Shevchenko wrote:
> On Mon, May 25, 2026 at 5:21 PM Stepan Ionichev <sozdayvek@gmail.com> wrote:
> >
> > ti_eqep_probe() calls pm_runtime_enable() and pm_runtime_get_sync()
> > before devm_clk_get_enabled(). If the clk call fails, the function
> > returns directly via dev_err_probe(), leaving runtime PM enabled
> > and the usage counter incremented.
> >
> > Route the clk error through the same err_pm cleanup as counter_add()
> > so the runtime PM state is unwound on every failure path.
> 
> ...
> 
> >         pm_runtime_get_sync(dev);
> >
> >         clk = devm_clk_get_enabled(dev, NULL);
> > -       if (IS_ERR(clk))
> > -               return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
> > +       if (IS_ERR(clk)) {
> > +               err = dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
> > +               goto err_pm;
> 
> This is not right. The devm_*() should not be followed by goto.
> 
> > +       }
> 
> ...
> 
> > +err_pm:
> > +       pm_runtime_put_sync(dev);
> > +       pm_runtime_disable(dev);
> > +       return err;
> 
> You have to use the respective devm_pm_*() at the same time.
> 
> ...
> 
> William, this patch should not be applied (or should be reverted) as
> in current form it replaces one issue by another.
> 
> --
> With Best Regards,
> Andy Shevchenko

I'll revert for now. Would the proper fix be to replace all
pm_runtime_*() with their respective devm_pm_*() calls?

William Breathitt Gray
