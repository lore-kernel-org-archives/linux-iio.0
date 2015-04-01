Return-Path: <cristina.opriceana@gmail.com>
Message-ID: <1427889004.6503.1.camel@Inspiron>
Subject: Re: [PATCH 2/2] iio: light: ltr501: Powerdown device on error
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, outreachy-kernel@googlegroups.com,
	"linux-iio@vger.kernel.org"
	 <linux-iio@vger.kernel.org>
Date: Wed, 01 Apr 2015 14:50:04 +0300
In-Reply-To: <CAEnQRZAVb_70+Fyj+PiXLQ3ShZTomafE3ZEnCFUEkhQnb8ERYg@mail.gmail.com>
References: <cover.1427797741.git.cristina.opriceana@gmail.com>
	 <1abedb2004323a23e8dd120abf761f3488c8e9f6.1427797741.git.cristina.opriceana@gmail.com>
	 <CAEnQRZAVb_70+Fyj+PiXLQ3ShZTomafE3ZEnCFUEkhQnb8ERYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mi, 2015-04-01 at 14:46 +0300, Daniel Baluta wrote:
> On Wed, Apr 1, 2015 at 2:01 PM, Cristina Opriceana
> <cristina.opriceana@gmail.com> wrote:
> > Power down device when an error occurs  in order to avoid wasting
> > power. Also move powerdown function up to be seen by the new call.
> >
> > Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
> > ---
> >  drivers/iio/light/ltr501.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> > index 62b7072..29ca4b8 100644
> > --- a/drivers/iio/light/ltr501.c
> > +++ b/drivers/iio/light/ltr501.c
> > @@ -333,6 +333,13 @@ static int ltr501_init(struct ltr501_data *data)
> >                 data->ps_contr);
> >  }
> >
> > +static int ltr501_powerdown(struct ltr501_data *data)
> > +{
> > +       return ltr501_write_contr(data->client,
> > +               data->als_contr & ~LTR501_CONTR_ACTIVE,
> > +               data->ps_contr & ~LTR501_CONTR_ACTIVE);
> > +}
> > +
> 
> While at it please also fix the alignment for ltr501_write_contr
> parameters. Don't forget
> to mention this in the commit message. When running checkpatch.pl
> please use --strict parameter.
> 
> thanks,
> Daniel.

Another patch would be fine or should I send a v2?

Cristina
