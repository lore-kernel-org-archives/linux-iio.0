Return-Path: <SRS0=2Wfx=M4=gmail.com=giuliano.belinassi@kernel.org>
MIME-Version: 1.0
References: <20181016210950.cmx4r4pb2yg5ofpp@smtp.gmail.com> <5717d448daad72d7eb142732ca88e9ed30854088.camel@perches.com>
In-Reply-To: <5717d448daad72d7eb142732ca88e9ed30854088.camel@perches.com>
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Tue, 16 Oct 2018 19:48:10 -0300
Message-ID: <CAG4RSAFMGSFyUqutRD2SRMsBt5RHVo5RUQsBq7fis6OVWxSZbg@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad7280a: Lines should not end with a '(' - style
To: joe@perches.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: multipart/alternative; boundary="000000000000c26f8705786059e5"
List-ID: <linux-iio@vger.kernel.org>

--000000000000c26f8705786059e5
Content-Type: text/plain; charset="UTF-8"

Hello,
    Thank you for your review :-).
    Sorry, but I am a newbie on this, and now I am confused about my next
step. Should I make a v2 based on your changes, or do you want to submit
your changes?



On Tue, Oct 16, 2018 at 6:59 PM Joe Perches <joe@perches.com> wrote:

> On Tue, 2018-10-16 at 18:09 -0300, Giuliano Belinassi wrote:
> > A number of macro calls cause a checkpatch issue:
> >
> >     "Lines should not end with a '('"
> >
> > This was fixed by moving the first '(' token to the line of the first
> > argument.
>
> Please try to make the code more readable instead of
> following mindless checkpatch messages.
>
> For instance, this could be shorter, simpler, smaller
> object code size, and easier to humans to read as:
> ---
>  drivers/staging/iio/adc/ad7280a.c | 68
> +++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/ad7280a.c
> b/drivers/staging/iio/adc/ad7280a.c
> index 58420dcb406d..a69ae76b5616 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -701,46 +701,38 @@ static irqreturn_t ad7280_event_handler(int irq,
> void *private)
>                 goto out;
>
>         for (i = 0; i < st->scan_cnt; i++) {
> -               if (((channels[i] >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6)
> {
> -                       if (((channels[i] >> 11) & 0xFFF) >=
> -                               st->cell_threshhigh)
> -                               iio_push_event(indio_dev,
> -                                              IIO_EVENT_CODE(IIO_VOLTAGE,
> -                                                       1,
> -                                                       0,
> -                                                       IIO_EV_DIR_RISING,
> -                                                       IIO_EV_TYPE_THRESH,
> -                                                       0, 0, 0),
> -                                              iio_get_time_ns(indio_dev));
> -                       else if (((channels[i] >> 11) & 0xFFF) <=
> -                               st->cell_threshlow)
> -                               iio_push_event(indio_dev,
> -                                              IIO_EVENT_CODE(IIO_VOLTAGE,
> -                                                       1,
> -                                                       0,
> -                                                       IIO_EV_DIR_FALLING,
> -                                                       IIO_EV_TYPE_THRESH,
> -                                                       0, 0, 0),
> -                                              iio_get_time_ns(indio_dev));
> +               unsigned int voltage = (channels[i] >> 23) & 0xF;
> +               unsigned int val = (channels[i] >> 11) & 0xFFF;
> +               u64 code = 0;
> +
> +               if (voltage <= AD7280A_CELL_VOLTAGE_6) {
> +                       if (val >= st->cell_threshhigh) {
> +                               code = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
> +                                                     IIO_EV_DIR_RISING,
> +                                                     IIO_EV_TYPE_THRESH,
> +                                                     0, 0, 0);
> +                       } else if (val <= st->cell_threshlow) {
> +                               code = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
> +                                                     IIO_EV_DIR_FALLING,
> +                                                     IIO_EV_TYPE_THRESH,
> +                                                     0, 0, 0);
> +                       } else {
> +                               continue;
> +                       }
>                 } else {
> -                       if (((channels[i] >> 11) & 0xFFF) >=
> st->aux_threshhigh)
> -                               iio_push_event(indio_dev,
> -                                              IIO_UNMOD_EVENT_CODE(
> -                                                       IIO_TEMP,
> -                                                       0,
> -                                                       IIO_EV_TYPE_THRESH,
> -                                                       IIO_EV_DIR_RISING),
> -                                              iio_get_time_ns(indio_dev));
> -                       else if (((channels[i] >> 11) & 0xFFF) <=
> -                               st->aux_threshlow)
> -                               iio_push_event(indio_dev,
> -                                              IIO_UNMOD_EVENT_CODE(
> -                                                       IIO_TEMP,
> -                                                       0,
> -                                                       IIO_EV_TYPE_THRESH,
> -
>  IIO_EV_DIR_FALLING),
> -                                              iio_get_time_ns(indio_dev));
> +                       if (val >= st->aux_threshhigh) {
> +                               code = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +
>  IIO_EV_TYPE_THRESH,
> +
>  IIO_EV_DIR_RISING);
> +                       } else if (val <= st->aux_threshlow) {
> +                               code = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +
>  IIO_EV_TYPE_THRESH,
> +
>  IIO_EV_DIR_FALLING);
> +                       } else {
> +                               continue;
> +                       }
>                 }
> +               iio_push_event(indio_dev, code,
> iio_get_time_ns(indio_dev));
>         }
>
>  out:
>
>
>

--000000000000c26f8705786059e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5IZWxsbyw8L2Rpdj48ZGl2PsKgwqDCoCBUaGFuayB5b3UgZm9y
IHlvdXIgcmV2aWV3IDotKS48L2Rpdj48ZGl2PsKgwqDCoCBTb3JyeSwgYnV0IEkgYW0gYSBuZXdi
aWUgb24gdGhpcywgYW5kIG5vdyBJIGFtIGNvbmZ1c2VkIGFib3V0IG15IG5leHQgc3RlcC4gU2hv
dWxkIEkgbWFrZSBhIHYyIGJhc2VkIG9uIHlvdXIgY2hhbmdlcywgb3IgZG8geW91IHdhbnQgdG8g
c3VibWl0IHlvdXIgY2hhbmdlcz88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFR1ZSwg
T2N0IDE2LCAyMDE4IGF0IDY6NTkgUE0gSm9lIFBlcmNoZXMgJmx0OzxhIGhyZWY9Im1haWx0bzpq
b2VAcGVyY2hlcy5jb20iPmpvZUBwZXJjaGVzLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5PbiBUdWUsIDIwMTgt
MTAtMTYgYXQgMTg6MDkgLTAzMDAsIEdpdWxpYW5vIEJlbGluYXNzaSB3cm90ZTo8YnI+DQomZ3Q7
IEEgbnVtYmVyIG9mIG1hY3JvIGNhbGxzIGNhdXNlIGEgY2hlY2twYXRjaCBpc3N1ZTo8YnI+DQom
Z3Q7IDxicj4NCiZndDvCoCDCoCDCoCZxdW90O0xpbmVzIHNob3VsZCBub3QgZW5kIHdpdGggYSAm
IzM5OygmIzM5OyZxdW90Ozxicj4NCiZndDsgPGJyPg0KJmd0OyBUaGlzIHdhcyBmaXhlZCBieSBt
b3ZpbmcgdGhlIGZpcnN0ICYjMzk7KCYjMzk7IHRva2VuIHRvIHRoZSBsaW5lIG9mIHRoZSBmaXJz
dDxicj4NCiZndDsgYXJndW1lbnQuPGJyPg0KPGJyPg0KUGxlYXNlIHRyeSB0byBtYWtlIHRoZSBj
b2RlIG1vcmUgcmVhZGFibGUgaW5zdGVhZCBvZjxicj4NCmZvbGxvd2luZyBtaW5kbGVzcyBjaGVj
a3BhdGNoIG1lc3NhZ2VzLjxicj4NCjxicj4NCkZvciBpbnN0YW5jZSwgdGhpcyBjb3VsZCBiZSBz
aG9ydGVyLCBzaW1wbGVyLCBzbWFsbGVyPGJyPg0Kb2JqZWN0IGNvZGUgc2l6ZSwgYW5kIGVhc2ll
ciB0byBodW1hbnMgdG8gcmVhZCBhczo8YnI+DQotLS08YnI+DQrCoGRyaXZlcnMvc3RhZ2luZy9p
aW8vYWRjL2FkNzI4MGEuYyB8IDY4ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLTxicj4NCsKgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9u
cygtKTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDcy
ODBhLmMgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDcyODBhLmM8YnI+DQppbmRleCA1ODQy
MGRjYjQwNmQuLmE2OWFlNzZiNTYxNiAxMDA2NDQ8YnI+DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcv
aWlvL2FkYy9hZDcyODBhLmM8YnI+DQorKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDcy
ODBhLmM8YnI+DQpAQCAtNzAxLDQ2ICs3MDEsMzggQEAgc3RhdGljIGlycXJldHVybl90IGFkNzI4
MF9ldmVudF9oYW5kbGVyKGludCBpcnEsIHZvaWQgKnByaXZhdGUpPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZ290byBvdXQ7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgZm9yIChpID0gMDsg
aSAmbHQ7IHN0LSZndDtzY2FuX2NudDsgaSsrKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgKCgoY2hhbm5lbHNbaV0gJmd0OyZndDsgMjMpICZhbXA7IDB4RikgJmx0Oz0gQUQ3Mjgw
QV9DRUxMX1ZPTFRBR0VfNikgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmICgoKGNoYW5uZWxzW2ldICZndDsmZ3Q7IDExKSAmYW1wOyAweEZGRikgJmd0Oz08YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdC0mZ3Q7
Y2VsbF90aHJlc2hoaWdoKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlpb19wdXNoX2V2ZW50KGluZGlvX2Rldiw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
SUlPX0VWRU5UX0NPREUoSUlPX1ZPTFRBR0UsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgMSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAwLDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoElJT19FVl9ESVJfUklTSU5HLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoElJT19FVl9UWVBFX1RIUkVTSCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAwLCAwLCAwKSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWlvX2dldF90aW1lX25zKGluZGlvX2Rl
dikpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVsc2UgaWYgKCgo
Y2hhbm5lbHNbaV0gJmd0OyZndDsgMTEpICZhbXA7IDB4RkZGKSAmbHQ7PTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0LSZndDtjZWxsX3RocmVz
aGxvdyk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpaW9fcHVzaF9ldmVudChpbmRpb19kZXYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElJT19FVkVOVF9D
T0RFKElJT19WT0xUQUdFLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDEsPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBJSU9fRVZfRElSX0ZBTExJTkcsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
SUlPX0VWX1RZUEVfVEhSRVNILDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDAsIDAs
IDApLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpaW9fZ2V0X3RpbWVfbnMoaW5kaW9fZGV2KSk7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdW5zaWduZWQgaW50IHZvbHRhZ2UgPSAoY2hhbm5lbHNb
aV0gJmd0OyZndDsgMjMpICZhbXA7IDB4Rjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1
bnNpZ25lZCBpbnQgdmFsID0gKGNoYW5uZWxzW2ldICZndDsmZ3Q7IDExKSAmYW1wOyAweEZGRjs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1NjQgY29kZSA9IDA7PGJyPg0KKzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICh2b2x0YWdlICZsdDs9IEFENzI4MEFfQ0VMTF9WT0xU
QUdFXzYpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAodmFs
ICZndDs9IHN0LSZndDtjZWxsX3RocmVzaGhpZ2gpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb2RlID0gSUlPX0VWRU5UX0NPREUoSUlPX1ZP
TFRBR0UsIDEsIDAsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgSUlPX0VWX0RJUl9SSVNJ
TkcsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgSUlPX0VWX1RZUEVfVEhSRVNILDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDAsIDAsIDApOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZSBpZiAodmFsICZsdDs9IHN0LSZndDtjZWxsX3RocmVz
aGxvdykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGNvZGUgPSBJSU9fRVZFTlRfQ09ERShJSU9fVk9MVEFHRSwgMSwgMCw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBJSU9fRVZfRElSX0ZBTExJTkcsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgSUlPX0VWX1RZUEVfVEhSRVNILDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDAsIDAsIDApOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxz
ZSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Y29udGludWU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0gZWxzZSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgaWYgKCgoY2hhbm5lbHNbaV0gJmd0OyZndDsgMTEpICZhbXA7IDB4
RkZGKSAmZ3Q7PSBzdC0mZ3Q7YXV4X3RocmVzaGhpZ2gpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWlvX3B1c2hfZXZlbnQoaW5kaW9fZGV2LDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBJSU9fVU5NT0RfRVZFTlRfQ09ERSg8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBJSU9fVEVNUCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAw
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoElJT19FVl9UWVBFX1RIUkVTSCw8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJSU9fRVZfRElSX1JJU0lORyksPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGlpb19nZXRfdGltZV9ucyhpbmRpb19kZXYpKTs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbHNlIGlmICgoKGNoYW5uZWxzW2ldICZndDsmZ3Q7IDEx
KSAmYW1wOyAweEZGRikgJmx0Oz08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBzdC0mZ3Q7YXV4X3RocmVzaGxvdyk8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpaW9fcHVzaF9ldmVudChpbmRpb19k
ZXYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIElJT19VTk1PRF9FVkVOVF9DT0RFKDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoElJT19URU1QLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDAsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgSUlPX0VWX1RZUEVfVEhSRVNI
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoElJT19FVl9ESVJfRkFMTElORyksPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGlpb19nZXRfdGltZV9ucyhpbmRpb19kZXYpKTs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAodmFsICZndDs9IHN0LSZndDthdXhfdGhy
ZXNoaGlnaCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGNvZGUgPSBJSU9fVU5NT0RfRVZFTlRfQ09ERShJSU9fVEVNUCwgMCw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJSU9fRVZfVFlQRV9USFJFU0gsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgSUlPX0VWX0RJUl9SSVNJTkcpOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZSBpZiAodmFsICZsdDs9IHN0
LSZndDthdXhfdGhyZXNobG93KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgY29kZSA9IElJT19VTk1PRF9FVkVOVF9DT0RFKElJT19URU1QLCAw
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoElJT19FVl9UWVBFX1RIUkVT
SCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJSU9fRVZfRElSX0ZBTExJ
TkcpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZSB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGlu
dWU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpaW9fcHVz
aF9ldmVudChpbmRpb19kZXYsIGNvZGUsIGlpb19nZXRfdGltZV9ucyhpbmRpb19kZXYpKTs8YnI+
DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KwqBvdXQ6PGJyPg0KPGJyPg0KPGJyPg0KPC9ibG9j
a3F1b3RlPjwvZGl2Pg0K
--000000000000c26f8705786059e5--
